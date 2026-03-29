import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();
class ExpenseModel {
  final double balance;
  final String note;
  final bool isExpense;

  ExpenseModel({
    required this.balance,
    required this.note,
    required this.isExpense,
  });
}
