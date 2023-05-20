import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gp/UI/Mom_UI/mom_profile_view.dart';
import 'package:gp/practice%20db/config.dart';
import 'package:http/http.dart' as http;
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

  Future<void> addMedicine() async {
    try {
      final response = await http.post(Uri.parse(medicineAdd),
          headers: {
            'Content-Type': 'application/json', // Example header
            'Authorization': 'Bearer your-token', // Example header
          },
          body: jsonEncode({
            'medicineName': medicineNameC.text,
            'daily': dailyMed,
            'noDays': noDaysC.text,
            'noDoses': noDoses,
            'childId': childChosenId,
            'details': details.text,
          }));

      if (response.statusCode == 200) {
        print('Medicine added successfully');
      } else {
        print('Failed to add medicine. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
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
}
