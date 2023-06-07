class MessageModel {
  String senderName = "";
  String messageDate = "";
  String message = "";
  String filterText = "";
  String totalAmountTile = "";
  double totalAmount = 0.0;

  MessageModel.empty();

  MessageModel.addData({
    required this.senderName,
    required this.messageDate,
    required this.message,
    required this.filterText,
    this.totalAmount = 0.0,
    this.totalAmountTile = "",
  });

  @override
  String toString() {
    return 'MessageModel{senderName: $senderName, messageDate: $messageDate, message: $message, filterText: $filterText, totalAmountTile: $totalAmountTile, totalAmount: $totalAmount}';
  }
}