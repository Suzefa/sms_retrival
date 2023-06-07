import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/message_model.dart';

class MyMessage with ChangeNotifier {
  MyMessage._();

  static List<MessageModel> myMessages = <MessageModel>[];
  static RxString searchMsg = "".obs;
  static RxDouble totalAMount = 0.0.obs;
  static ValueNotifier<String> onChange = ValueNotifier<String>("_value");

}