import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/message_model.dart';
import '../../service/my_message.dart';
import '../../utils/date_time_formatter.dart';
import '../../utils/regex_utils.dart';
import 'custom_price_card.dart';

class CustomMonthCard extends StatefulWidget {
  final String monthName;

  const CustomMonthCard({
    super.key,
    required this.monthName,
  });

  @override
  State<CustomMonthCard> createState() => _CustomMonthCardState();
}

class _CustomMonthCardState extends State<CustomMonthCard> with ValidatePayment {
  RxString filterText = "".obs;
  RxInt pageSize = 10.obs;
  RxDouble totalAmount = 0.0.obs;
  RxBool loadMore = false.obs,
      isWidgetReady=false.obs;
  RxList<MessageModel> filterMsg = RxList<MessageModel>();

  void maintainData() {
    filterMsg.value = MyMessage.myMessages
        .where((element) => element.filterText.contains(filterText.value))
        .toList();
    if(filterMsg.isEmpty){
      loadMore.value = false;
      return;
    }
    if(filterMsg.length>10){
      loadMore.value = true;
    } else {
      loadMore.value = false;
      pageSize.value = filterMsg.length;
    }
    isWidgetReady.value = true;
    updateTotal();
    MyMessage.onChange.addListener(updateTotal);
  }

  void loadMoreMsg() {
    loadMore.value = false;
    pageSize.value = pageSize.value + 10;
    if(filterMsg.length>pageSize.value){
      loadMore.value = true;
    } else {
      loadMore.value = false;
      pageSize.value = filterMsg.length;
    }

  }

  @override
  void initState() {
    super.initState();
    filterText.value = widget.monthName;
    maintainData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black26,
        ),
        borderRadius: BorderRadius.circular(
          20.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${DateTimeFormatter.formatDateMonth(widget.monthName.split("/").last)}-${widget.monthName.split("/").first}",
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Divider(
            color: Colors.black26,
            thickness: 1.5,
          ),
          Obx((){
            if(isWidgetReady.isFalse){
              return const Center(
                child: Text(
                  "Loading messages please wait",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
            if(MyMessage.searchMsg.isNotEmpty){
              return Column(
                children: [
                  for(MessageModel msg in filterMsg)
                    if(msg.senderName.toLowerCase().contains(MyMessage.searchMsg.value.toLowerCase()))
                      Builder(
                        builder: (context){
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: CustomPriceCard(messageModel: msg,),
                          );
                        },
                      ),

                ],
              );
            }
            return Column(
              children: [
                for(int index=0; index<pageSize.value;index++)
                  if(filterText.contains(filterMsg[index].filterText))
                    Builder(
                      builder: (context){
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: CustomPriceCard(messageModel: filterMsg[index],),                        );
                      },
                    ),
                Obx((){
                  return Visibility(
                    visible: loadMore.value,
                    child: GestureDetector(
                      onTap: loadMoreMsg,
                      child: const Text(
                        "Load More",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Monthly total:",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Obx((){
                  return Text(
                    "${totalAmount.value} AED",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateTotal() {
    if(MyMessage.searchMsg.isNotEmpty){
      totalAmount.value = 0.0;
      for (var value in filterMsg) {
        if(value.senderName.toLowerCase().contains(MyMessage.searchMsg.value.toLowerCase())){
          totalAmount.value = totalAmount.value + value.totalAmount;
        }
      }
      return;
    }
    totalAmount.value = 0.0;
    for (var value in filterMsg) {
      totalAmount.value = totalAmount.value + value.totalAmount;
    }
  }

}
