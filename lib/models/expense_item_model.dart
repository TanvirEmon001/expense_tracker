import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

class ExpenseItemModel {
  final String id;
  final String itemName;
  double balance;
  final DateTime dateTime;

  String get formattedDate => formatter.format(dateTime);

  ExpenseItemModel({
    String? id,
    required this.itemName,
    required this.balance,
    required this.dateTime,
  }) : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "itemName": itemName,
      "balance": balance,
      "dateTime": dateTime.toIso8601String(),
    };
  }

  factory ExpenseItemModel.fromMap(Map<String, dynamic> map) {
    return ExpenseItemModel(
      id: map["id"],
      itemName: map["itemName"],
      balance: (map["balance"] as num).toDouble(),
      dateTime: DateTime.parse(map["dateTime"]),
    );
  }
}
