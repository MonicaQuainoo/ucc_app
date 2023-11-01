import 'package:flutter/material.dart';
import 'package:logged/src/screens/constants/logs.dart';
import 'package:logged/src/services/object_box.dart';

class ActiveState extends ChangeNotifier {
  ObjectBox? _objectbox;

  ObjectBox? get activeObject => _objectbox;

  void setActiveObject(ObjectBox activeClass) {
    _objectbox = activeClass;
    notifyListeners();
  }

  Future<void> initialise() async {
    _objectbox = await ObjectBox.create();
    notifyListeners();
    logger.d((await _objectbox?.getActives().first).toString());
  }
}
