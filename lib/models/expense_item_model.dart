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
    required this.itemName,
    required this.balance,
    required this.dateTime
  }) : id = uuid.v4();

}
