import 'package:flutter/material.dart';
import 'package:logged/src/screens/constants/logs.dart';
import 'package:logged/src/services/object_box.dart';

class ActiveState extends ChangeNotifier {
  late ObjectBox? _objectbox;

  ObjectBox get activeObject => _objectbox!;

  void setActiveObject(ObjectBox activeClass) {
    _objectbox = activeClass;
     notifyListeners();
  }

   initialise() async {
    _objectbox = await ObjectBox.create();
    notifyListeners();
    logger.d(_objectbox);
  }
}
