import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat('dd/MM/yyyy, hh:mm a', 'en');
class BalanceItemModel {
  final String itemId;
  final String id;
  final String title;
  final double updatedBalance;
  final bool isExpense;
  final DateTime dateTime;

  String get formattedDate => formatter.format(dateTime);

  BalanceItemModel({
    required this.itemId,
    required this.title,
    required this.updatedBalance,
    required this.isExpense,
    required this.dateTime
  }) : id = uuid.v4();


}
