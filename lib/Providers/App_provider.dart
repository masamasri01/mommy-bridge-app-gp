import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gp/practice%20db/config.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class AppProvider extends ChangeNotifier {
  bool hasSpeech = true;
  sethasSpeech(hasSpeech) {
    hasSpeech = hasSpeech;
  }

  DateTime today = DateTime.now();
  late String userToken;
  setUserToken(String? token) {
    userToken = token!;
  }

  late List<int> indexSelected = List.filled(50, 0);
  setIndexSelected(int index, n) {
    if (indexSelected.length <= index) {
      // indexSelected.length = index + 1;
      indexSelected.fillRange(indexSelected.length - 1, index, 0);
    }
    indexSelected[index] = n;
    notifyListeners();
  }

/**************************************************** */
  late List<bool> attendance = List.filled(50, true);
  setattendance(int index, bool n) {
    if (attendance.length <= index) {
      attendance.length = index + 1;
      attendance.fillRange(attendance.length - 1, index, true);
    }
    attendance[index] = n;
    notifyListeners();
  }
/**************************************************** */

  late String userId;
  TextEditingController announceController = TextEditingController();
  createAnnouncement() async {
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(userToken);
    userId = jwtDecodedToken['_id'];

    if (announceController.text.isNotEmpty) {
      var regBody = {
        "announce": announceController.text,
        "teacherId": jwtDecodedToken[userId]
      };

      var response = await http.post(Uri.parse(announceAdd),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);

      if (jsonResponse['status']) {
        announceController.clear();
      } else {
        print("SomeThing Went Wrong");
      }
    }
  }
}
