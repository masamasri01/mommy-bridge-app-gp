import 'dart:convert';
import 'dart:io';
import 'package:gp/practice%20db/config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:path/path.dart' as path;

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

  getMyClassChildrenList() async {
    var regBody = {"teacherId": teacherId};

    var response = await http.post(Uri.parse(MyChildrenListGet),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    myChildrenList = jsonResponse['success'];

    print("count of children = " + myChildrenList.length.toString());
    print(jsonResponse['success'].toString());
    return myChildrenList;
  }

  getMyChildData(String childId) async {
    //  print("reached function get child data");
    final String url = '${getChildData}$childId';
    final response = await http.get(Uri.parse(url));
    final jsonResponse = json.decode(response.body);
    //print(jsonResponse);
    setChildData(jsonResponse);
    notifyListeners();
    return jsonResponse;
  }

  var childData;
  setChildData(data) {
    childData = data;
  }

  /************** */
  bool? isTeacher = true;
  bool? isMom = false;
  File? childImageFile;
  File? activityImageFile;

  void pickImageForActivity(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      activityImageFile = File(pickedFile.path);
      print("activityImageFile===" + pickedFile.path);
      await uploadImage();
      notifyListeners();
    }
  }

  Future<void> uploadImage() async {
    final url = Uri.parse('http://192.168.1.9:3000/activities');
    final request = http.MultipartRequest('POST', url);
    request.fields['description'] =
        'Activity Title'; // Replace with your activity title

    final fileStream = http.ByteStream(
        activityImageFile!.openRead()); // Get the image file stream
    final fileLength =
        await activityImageFile!.length(); // Get the image file length

    String fileName = activityImageFile!.path.split('/').last;
    print(fileName);
    final multipartFile = http.MultipartFile(
      'image',
      fileStream,
      fileLength,
      filename: fileName,
    ); // Create a multipart file
  }

  void pickImageForChild(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      childImageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  setactivityImageFileNULL() {
    activityImageFile = null;
    notifyListeners();
  }

  /************************************* */

  TextEditingController enteryTimeController = TextEditingController();
  TextEditingController pickUpTimeController = TextEditingController();
}
