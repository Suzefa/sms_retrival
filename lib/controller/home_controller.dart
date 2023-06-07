import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/message_model.dart';
import '../service/my_message.dart';
import '../service/sms_service.dart';

class HomeController extends GetxController {
  final GlobalKey<ScaffoldState> screenKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();
  final SmsService _service = SmsService();
  RxBool isDataRetrieve = false.obs;
  RxList<String> messageDates = RxList<String>();
  RxString dataRetrievalErrorMsg = "".obs;
  String searchMsg = "";

  void removeFocus() {
    FocusScope.of(screenKey.currentContext!).unfocus();
  }

  void getAllMessage() async {
    if(await Permission.sms.status.isGranted){
      isDataRetrieve.value = false;
      var result = await _service.getAllMessages();
      if(result is List<MessageModel>){
        MyMessage.myMessages = result;
        for(MessageModel msg in result) {
          if(!messageDates.contains(msg.filterText)){
            messageDates.add(msg.filterText);
          }
        }
        log(" Dates ===== > ${messageDates.toString()}");
      } else {
        dataRetrievalErrorMsg.value = "No Messages Founds";
      }
      isDataRetrieve.value = true;
      updateValue();
      MyMessage.onChange.addListener(updateValue);
      return;
    }
    await Permission.sms.request();
    getAllMessage();
  }

  @override
  void onReady() {
    getAllMessage();
    super.onReady();
  }

  @override
  void dispose() {
    MyMessage.onChange.removeListener((){});
    Get.delete<HomeController>();
    super.dispose();
  }

  void updateValue(){
    if(MyMessage.searchMsg.isNotEmpty){
      MyMessage.totalAMount.value = 0.0;
      for(var value in MyMessage.myMessages) {
        if(value.senderName.toLowerCase().contains(MyMessage.searchMsg.toLowerCase())){
          MyMessage.totalAMount.value = MyMessage.totalAMount.value + value.totalAmount;
        }
      }
      return;
    }
    MyMessage.totalAMount.value = 0.0;
    for(var value in MyMessage.myMessages) {
      MyMessage.totalAMount.value = MyMessage.totalAMount.value + value.totalAmount;
    }
  }

}