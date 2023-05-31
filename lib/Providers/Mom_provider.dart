import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gp/UI/Mom_UI/mom_profile_view.dart';
import 'package:gp/practice%20db/config.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class MomProvider extends ChangeNotifier {
  late String userToken;
  String? momId;
  var savedJsonRes;
  var momData;

  setUserToken(String? token) {
    userToken = token!;
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(token);

    momId = jwtDecodedToken['_id'];
    setMomData();
    getMySonsList();
    notifyListeners();
  }

  setSavedJsonRes(res) {
    savedJsonRes = res;
  }

  // setMomId(userId) async {
  //   momId = userId;
  //   notifyListeners();
  // }

  late List mySonsList;
  setSonsList(mySonsList) {
    mySonsList = mySonsList;
    notifyListeners();
  }

  setMomData() async {
    var response = await http.get(Uri.parse("$getMomData${momId}"));

    momData = jsonDecode(response.body);

    notifyListeners();
  }

  void getMySonsList() async {
    var regBody = {"momId": momId};

    var response = await http.post(Uri.parse(MySonsGet),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    mySonsList = jsonResponse['success'];
    notifyListeners();
  }

  /********************************************************************** */
  TextEditingController preferenceNameController = TextEditingController();

  TextEditingController allergyNameController = TextEditingController();
  late dynamic childData;
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

  setChildData(data) {
    childData = data;
  }

  Future<void> addAllergy(String id, String allergy) async {
    final String url = '$getChildData$id/allergy';

    try {
      if (allergy != null && allergy.isNotEmpty) {
        final response = await http.patch(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'allergy': allergy}),
        );

        if (response.statusCode == 200) {
          print('Allergy added successfully');
        } else {
          print('Failed to add allergy. Status code: ${response.statusCode}');
        }
      } else {
        print('Invalid allergy value');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  Future<void> addHobby(String id, String hobby) async {
    final String url = '$getChildData$id/hobby';

    try {
      if (hobby != null && hobby.isNotEmpty) {
        final response = await http.patch(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'hobby': hobby}),
        );
        if (response.statusCode == 200) {
          print('Allergy added successfully');
        } else {
          print('Failed to add allergy. Status code: ${response.statusCode}');
        }
      } else {
        print('Invalid allergy value');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

////////medicine
  TextEditingController medicineNameC = TextEditingController();
  TextEditingController noDaysC = TextEditingController();
  TextEditingController noDoses = TextEditingController();
  TextEditingController details = TextEditingController();
  String? childChosenId;
  setChildChosenId(s) {
    childChosenId = s;
  }

  bool dailyMed = true;
  setDailyMed(bool v) {
    dailyMed = v;
    notifyListeners();
  }

  addMedicine() async {
    try {
      // print("object________!");
      final response = await http.post(Uri.parse(medicineAdd),
          headers: {
            'Content-Type': 'application/json', // Example header
          },
          body: jsonEncode({
            'medicineName': medicineNameC.text,
            'daily': dailyMed,
            'noDays': noDaysC.text,
            'noDoses': noDoses.text,
            'childId': childChosenId,
            'details': details.text,
          }));
      //print("object____________________" + response.statusCode.toString());
      if (response.statusCode == 200) {
        print('Medicine added successfully');
      } else {
        print('Failed to add medicine. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  var medicines;
  Future<List<dynamic>> getMed() async {
    return await medicines;
  }

  Future<List<dynamic>> fetchMedicines() async {
    final url = '$getMySonsMedicine$momId';

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

  TextEditingController addressC = TextEditingController();
  updateChildAddresss() async {
    if (addressC.text.isNotEmpty) {
      var regBody = {"childId": childData["_id"], "newAddress": addressC.text};
      print("masssaa" + childData["_id"]);
      var response = await http.post(Uri.parse(updateChildAddress),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        addressC.clear();
        getMyChildData(childData["_id"]);
        notifyListeners();
      } else {
        print("SomeThing Went Wrong");
      }
    }
  }

  /// *********************************************************************/

  updatePhone() async {
    if (editC.text.isNotEmpty) {
      var regBody = {"momId": momId, "newPhone": editC.text};
      var response = await http.post(Uri.parse(updateMomPhone),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        editC.clear();
      } else {
        print("SomeThing Went Wrong");
      }
    }
  }

  updateJob() async {
    if (editC.text.isNotEmpty) {
      var regBody = {"momId": momId, "newJob": editC.text};
      var response = await http.post(Uri.parse(updateMomJob),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        editC.clear();
        setMomData();
      } else {
        print("SomeThing Went Wrong");
      }
    }
  }

  updateAddress() async {
    if (editC.text.isNotEmpty) {
      var regBody = {"momId": momId, "newAddress": editC.text};
      var response = await http.post(Uri.parse(updateMomAddress),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        editC.clear();
        setMomData();
      } else {
        print("SomeThing Went Wrong");
      }
    }
  }

  updateRelation() async {
    if (editC.text.isNotEmpty) {
      var regBody = {"momId": momId, "newRelationship": editC.text};
      var response = await http.post(Uri.parse(updateMomRelationship),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        editC.clear();
        setMomData();
      } else {
        print("SomeThing Went Wrong");
      }
    }
  }

  File? MomImageFile;

  void pickImageForMom(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      MomImageFile = File(pickedFile.path);
      notifyListeners();
    }
    if (MomImageFile != null) {
      print("reached");
      var request = http.MultipartRequest('POST', Uri.parse(updateMomImage));
      print("reached3");
      request.files
          .add(await http.MultipartFile.fromPath('image', MomImageFile!.path));
      request.fields['momId'] = momId!;
      print("reached2");
      var response = await request.send();
      print("fdf" + response.statusCode.toString());
      if (response.statusCode == 201) {
        // description.clear();

        print('Image uploaded successfully');
      } else {
        print('Image upload failed');
      }
    }
    setMomData();
    notifyListeners();
  }
}
