import 'dart:developer';

import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

import '../model/message_model.dart';
import '../utils/regex_utils.dart';

class SmsService with ValidatePayment {
  SmsService._();

  static final SmsService _instance = SmsService._();

  factory SmsService(){
    return _instance;
  }

  final SmsQuery _query = SmsQuery();

  Future<dynamic> getAllMessages() async {
    final List<SmsMessage> messages = await _query.querySms(
      kinds: [
        SmsQueryKind.inbox,
        // SmsQueryKind.sent,
      ],
    );
    if(messages.isNotEmpty){
      final List<MessageModel> myMessage = <MessageModel>[];
      for(SmsMessage smsMessage in messages){
        myMessage.add(
          MessageModel.addData(
            senderName: smsMessage.sender ?? "",
            messageDate: "${smsMessage.date ?? DateTime.now()}",
            message: smsMessage.body ?? "",
            filterText: "${smsMessage.date?.year}/${smsMessage.date?.month}",
            totalAmount: paymentValue(smsMessage.body ?? ""),
            totalAmountTile: paymentTitle(smsMessage.body ?? ""),
          ),
        );
      }
      log("======> ${myMessage.first}");
      return myMessage;
    } else {
      return "No new messages";
    }
  }
}