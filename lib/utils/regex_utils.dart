import 'package:flutter/material.dart';

import '../model/payment_model.dart';

mixin ValidatePayment {

  final RegExp _payment = RegExp(r'\d+(\.\d+)?\s[A-Z]{3}');

  PaymentModel filterPayment(String payment,{ValueChanged<double>? onChange}){
    String filter = _payment.firstMatch(payment)?.group(0) ?? "";
    if(filter.endsWith("AED")){
      double pay = double.parse(filter.split(" ").first);
      if(onChange!=null){
        onChange(pay);
      }
      return PaymentModel.addNew(
        paymentTitle: filter,
        paymentValue: pay,
      );
    } else {
      if(onChange!=null){
        onChange(0.0);
      }
      return PaymentModel.addNew(
        paymentTitle: "0.0 AED",
        paymentValue: 0.0,
      );
    }
  }

  double paymentValue(String payment,) {
    String filter = _payment.firstMatch(payment)?.group(0) ?? "";
    if(filter.endsWith("AED")){
      double pay = double.parse(filter.split(" ").first);
      return pay;
    } else {
      return 0.0;
    }
  }

  String paymentTitle(String payment,) {
    String filter = _payment.firstMatch(payment)?.group(0) ?? "";
    if(filter.endsWith("AED")){
      return filter;
    } else {
      return "0.0 AED";
    }
  }
}