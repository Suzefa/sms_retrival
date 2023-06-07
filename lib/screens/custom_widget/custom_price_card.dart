import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/message_model.dart';
import '../../utils/date_time_formatter.dart';
import '../../utils/regex_utils.dart';

class CustomPriceCard extends StatefulWidget {
  final MessageModel messageModel;
  const CustomPriceCard({super.key, required this.messageModel,});

  @override
  State<CustomPriceCard> createState() => _CustomPriceCardState();
}

class _CustomPriceCardState extends State<CustomPriceCard> with ValidatePayment {
  RxBool showFullMsg = false.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.messageModel.senderName,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                DateTimeFormatter.formatDate(widget.messageModel.messageDate),
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const  EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                paymentTitle(widget.messageModel.message,),
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: ()=> showFullMsg.toggle(),
                child: Obx((){
                  return Text(
                    showFullMsg.value ? "Hide full message" : "Show full message",
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black26,
                    ),
                  );
                })
              ),
            ],
          ),
        ),
        Obx((){
          return Visibility(
            visible: showFullMsg.value,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(20.0,),
                ),
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  widget.messageModel.message,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

}
