import 'dart:convert';
import 'dart:io';
import 'package:gp/UI/Mom_UI/Feed.dart';
import 'package:gp/practice%20db/config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class TeacherProvider extends ChangeNotifier {
  late String userToken;
  String? teacherId;
  var savedJsonRes;
  var teacherData;

  setUserToken(String? token) {
    userToken = token!;
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);

    teacherId = jwtDecodedToken['_id'];
    setTeacherData();
    print("done set teacher data");
    getMyClassChildrenList();
    notifyListeners();
  }

  setSavedJsonRes(res) {
    savedJsonRes = res;
  }

  // setMomId(userId) async {
  //   momId = userId;
  //   notifyListeners();
  // }

  late List myChildrenList;
  setmyChildrenList(myChildrenListt) {
    myChildrenList = myChildrenListt;
    notifyListeners();
  }

  setTeacherData() async {
    var response = await http.get(Uri.parse("$getTeacherData${teacherId}"));

    teacherData = jsonDecode(response.body);

    notifyListeners();
  }

  getTeacherName(id) async {
    var response = await http.get(Uri.parse("$getTeacherData${id}"));

    teacherData = jsonDecode(response.body);
    return teacherData['name'];
  }

  getTeacherImage(id) async {
    var response = await http.get(Uri.parse("$getTeacherData${id}"));

    teacherData = jsonDecode(response.body);
    return teacherData['image']['data'];
  }

  getMyClassChildrenList() async {
    var regBody = {"teacherId": teacherId};

    var response = await http.post(Uri.parse(MyChildrenListGet),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    myChildrenList = jsonResponse['success'];

    // print("count of children = " + myChildrenList.length.toString());
    //  print(jsonResponse['success'].toString());
    return myChildrenList;
  }

  late dynamic childData;
  Future<dynamic> getMyChildData(String childId) async {
    //  print("reached function get child data");
    final String url = '${getChildData}$childId';
    final response = await http.get(Uri.parse(url));
    final jsonResponse = json.decode(response.body);
    //  print("got child data" + jsonResponse.toString());
    setChildData(jsonResponse);
    notifyListeners();
    return jsonResponse;
  }

  Future<dynamic> getMyChildName(String childId) async {
    print("reached function get child data");
    final String url = '${getChildData}$childId';
    final response = await http.get(Uri.parse(url));
    final jsonResponse = json.decode(response.body);
    print("got child data" + jsonResponse.toString());
    // setChildData(jsonResponse);
    // notifyListeners();
    return jsonResponse['fullName'];
  }

  setChildData(data) {
    childData = data;
    // print("set data");
    notifyListeners();
  }

  /************** */
  bool? isTeacher = true;
  bool? isMom = false;
  File? childImageFile;
  File? teacherImageFile;
  File? activityImageFile;

  TextEditingController description = TextEditingController();
  void pickImageForActivity(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      activityImageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadImage() async {
    if (activityImageFile != null) {
      var request = http.MultipartRequest('POST', Uri.parse(activityAdd));
      request.files.add(
          await http.MultipartFile.fromPath('image', activityImageFile!.path));
      request.fields['description'] = description.text;
      request.fields['teacherId'] = teacherId!;
      var response = await request.send();
      if (response.statusCode == 201) {
        description.clear();
        setactivityImageFileNULL();

        print('Image uploaded successfully');
      } else {
        print('Image upload failed');
      }
    }
  }

  setactivityImageFileNULL() {
    activityImageFile = null;
    notifyListeners();
  }

  Future<List<Activity>> fetchActivities() async {
    final url = Uri.parse(getActiviies);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Activity> activities = [];

      for (var item in data) {
        final teacherName = await getTeacherName(item['teacherId']);

        final activity = Activity(
            description: item['description'],
            image: base64Decode(item['image']),
            timestamp: item['createdAt'] != null
                ? DateTime.parse(item['createdAt'])
                : DateTime.now(),
            teacherName: teacherName,
            profileImage: await getTeacherImage(item['teacherId']));

        activities.add(activity);
      }

      return activities;
    } else {
      throw Exception('Failed to fetch activities');
    }
  }

  DateTime selectedDate = DateTime.now();
  setSelectedDate(date) {
    selectedDate = date;
    notifyListeners();
  }

  Future<List<Activity>> getActivitiesByDate(selectedDate) async {
    final activities = await fetchActivities();

    // Filter activities based on the selected date
    final filteredActivities = activities.where((activity) {
      final activityDate = activity.timestamp.toLocal();
      final formattedActivityDate =
          DateTime(activityDate.year, activityDate.month, activityDate.day);
      final formattedSelectedDate =
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
      return formattedActivityDate == formattedSelectedDate;
    }).toList();

    return filteredActivities;
  }

  /************************************* */
  void pickImageForChild(ImageSource imageSource, childId) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      childImageFile = File(pickedFile.path);
      notifyListeners();
    }
    if (childImageFile != null) {
      var request = http.MultipartRequest('POST', Uri.parse(updateChildImage));

      request.files.add(
          await http.MultipartFile.fromPath('image', childImageFile!.path));
      request.fields['childId'] = childId!;

      var response = await request.send();
      if (response.statusCode == 201) {
        // description.clear();

        print('Image uploaded successfully');
      } else {
        print('Image upload failed');
      }
    }
    setTeacherData();
    notifyListeners();
  }

  void pickImageForTeacher(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      teacherImageFile = File(pickedFile.path);
      notifyListeners();
    }
    if (teacherImageFile != null) {
      // print("reached");
      var request =
          http.MultipartRequest('POST', Uri.parse(updateTeacherImage));
      // print("reached3");
      request.files.add(
          await http.MultipartFile.fromPath('image', teacherImageFile!.path));
      request.fields['teacherId'] = teacherId!;
      //  print("reached2");
      var response = await request.send();
      //  print("fdf" + response.statusCode.toString());
      if (response.statusCode == 201) {
        // description.clear();

        print('Image uploaded successfully');
      } else {
        print('Image upload failed');
      }
    }
    setTeacherData();
    notifyListeners();
  }

  TextEditingController enteryTimeController = TextEditingController();
  TextEditingController pickUpTimeController = TextEditingController();

  TextEditingController phoneC = TextEditingController();

  updatePhone() async {
    if (phoneC.text.isNotEmpty) {
      var regBody = {"teacherId": teacherId, "newPhone": phoneC.text};
      var response = await http.post(Uri.parse(updateTeacherPhone),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        phoneC.clear();
      } else {
        print("SomeThing Went Wrong");
      }
    }
  }

  /*********************************** */
  var medicines;
  Future<List<dynamic>> getMed() async {
    return await medicines;
  }

  Future<List<dynamic>> fetchMedicines() async {
    final url = '$getMyChildrenMedicine$teacherId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        medicines = jsonData['medicines'] as List<dynamic>;
        notifyListeners();
        return medicines;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
    }
    medicines = [];
    return [];
  }

/******************** */
  var momData;

// Function to retrieve mom data by child ID
  getMomDataByChildId(String childId) async {
    try {
      print("child id= " + childId);
      final response =
          await http.get(Uri.parse('$getChildMomData$childId/mom'));
      print("respomse= " + response.body.toString());
      if (response.statusCode == 200) {
        // Successful response
        final jsonData = json.decode(response.body);
        momData = jsonData;
        notifyListeners();
        return jsonData;
      } else if (response.statusCode == 404) {
        // Child not found
        print('Child not found');
        // return null;
      } else {
        // Error response
        print('Error retrieving mom data: ${response.statusCode}');
        // return null;
      }
    } catch (error) {
      // Handle any exceptions
      print('Error retrieving mom data: $error');
      // return null;
    }
  }
}
