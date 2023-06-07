import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';
import '../service/my_message.dart';
import 'custom_widget/custom_app_bar.dart';
import 'custom_widget/custom_month_card.dart';
import 'custom_widget/custom_search_field.dart';

class HomeScreen extends StatefulWidget {
  final HomeController controller;
  const HomeScreen({super.key, required this.controller});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.controller.removeFocus,
      child: Scaffold(
        key: widget.controller.screenKey,
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomSearchField(
                controller: widget.controller.searchController,
                onChanged: (text){
                  MyMessage.searchMsg.value = text;
                  MyMessage.onChange.value = text;
                },
              ),
              Expanded(
                child: Obx((){
                  if(widget.controller.isDataRetrieve.isFalse){
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black26,
                      ),
                    );
                  }
                  if (widget.controller.dataRetrievalErrorMsg.isNotEmpty) {
                    return Center(
                      child: Text(
                        widget.controller.dataRetrievalErrorMsg.value,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }
                  return Obx((){
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10.0,),
                      shrinkWrap: true,
                      itemCount: widget.controller.messageDates.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: CustomMonthCard(
                            monthName: widget.controller.messageDates[index],
                          ),
                        );
                      },
                    );
                  });
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Total:",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Obx((){
                    return Text(
                      "${MyMessage.totalAMount.value} AED",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
