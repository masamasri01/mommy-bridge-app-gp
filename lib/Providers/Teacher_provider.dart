import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class TeacherProvider extends ChangeNotifier {
  TextEditingController accidentController = TextEditingController();
  bool? isTeacher = true;
  bool? isMom = false;
  File? activityImageFile;
  File? childImageFile;
  void pickImageForActivity(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      activityImageFile = File(pickedFile.path);
      notifyListeners();
    }
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
}
