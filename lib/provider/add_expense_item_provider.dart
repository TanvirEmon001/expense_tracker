import 'package:flutter/foundation.dart';
import 'package:track_expense/models/expense_item_model.dart';

class AddExpenseItemProvider extends ChangeNotifier {
  List<ExpenseItemModel> _expenseItemLists = [
    ExpenseItemModel(
      itemName: "Get my Salary",
      balance: 20000,
      dateTime: DateTime.now(),
    ),
    ExpenseItemModel(
      itemName: "Loan From Friend",
      balance: 500,
      dateTime: DateTime.now(),
    ),
  ];
  List<ExpenseItemModel> get expenseItemLists => _expenseItemLists;

  void addExpenseItem(ExpenseItemModel items){
    _expenseItemLists.add(items);
    notifyListeners();
  }


  void setInitialItems(List<ExpenseItemModel> items) {
    _expenseItemLists = items;
  }

  void updateItem({
    required int index,
    required double amount,
    required bool isExpense,
  }) {
    if (isExpense) {
      if(_expenseItemLists[index].balance <= 0){
        return;
      } else {
        _expenseItemLists[index].balance -= amount;
      }

    }else {
      _expenseItemLists[index].balance += amount;
    }

    notifyListeners();
  }





}