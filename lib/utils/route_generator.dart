import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_retrival/controller/home_controller.dart';
import 'package:sms_retrival/screens/home_screen.dart';
import 'package:sms_retrival/utils/route_name.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generate(RouteSettings settings) {
    if (settings.name == RouteName.kInitialRoute) {
      return MaterialPageRoute(
        builder: (builder) {
          return HomeScreen(
            controller: Get.put(HomeController()),
          );
        },
      );
    }
    return null;
  }
}
