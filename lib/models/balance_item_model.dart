import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat('dd/MM/yyyy, hh:mm a', 'en');

class BalanceItemModel {
  final String id;
  final String itemId;
  final String title;
  final double updatedBalance;
  final bool isExpense;
  final DateTime dateTime;

  String get formattedDate => formatter.format(dateTime);

  BalanceItemModel({
    String? id,
    required this.itemId,
    required this.title,
    required this.updatedBalance,
    required this.isExpense,
    required this.dateTime,
  }) : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "itemId": itemId,
      "title": title,
      "updatedBalance": updatedBalance,
      "isExpense": isExpense ? 1 : 0,
      "dateTime": dateTime.toIso8601String(),
    };
  }

  factory BalanceItemModel.fromMap(Map<String, dynamic> map) {
    return BalanceItemModel(
      id: map["id"],
      itemId: map["itemId"],
      title: map["title"],
      updatedBalance: map["updatedBalance"],
      isExpense: map["isExpense"] == 1,
      dateTime: DateTime.parse(map["dateTime"]),
    );
  }
}
