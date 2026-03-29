import 'package:flutter/material.dart';
import 'package:track_expense/models/expense_item_model.dart';

class UpdateExpenseProvider extends ChangeNotifier {
  List<ExpenseItemModel> _items = [];

  List<ExpenseItemModel> get items => _items;

  void addItem(ExpenseItemModel item) {
    _items.add(item);
    notifyListeners();
  }

  void setInitialItems(List<ExpenseItemModel> items) {
    _items = items;
  }

  void updateItem({
    required int index,
    required double amount,
    required bool isExpense,
  }) {
    if (isExpense) {
      _items[index].balance -= amount;
    } else {
      _items[index].balance += amount;
    }

    notifyListeners();
  }
}