import 'package:flutter/cupertino.dart';

class MomProvider extends ChangeNotifier {
  bool dailyMed = true;
  setDailyMed(bool v) {
    dailyMed = v;
    notifyListeners();
  }

  TextEditingController preferenceNameController = TextEditingController();

  TextEditingController allergyNameController = TextEditingController();
}
