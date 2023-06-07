class PaymentModel {
  String paymentTitle = "";
  double paymentValue = 0.0;

  PaymentModel.addNew({required this.paymentTitle, required this.paymentValue,});

  PaymentModel.empty();

  @override
  String toString() {
    return 'PaymentModel{paymentTitle: $paymentTitle, paymentValue: $paymentValue}';
  }
}