import 'package:flutter/foundation.dart';
import 'package:track_expense/database/database_helper.dart';
import 'package:track_expense/models/expense_item_model.dart';

class AddExpenseItemProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<ExpenseItemModel> _expenseItemLists = [];
  List<ExpenseItemModel> get expenseItemLists => _expenseItemLists;


  Future<void> loadExpenseItem() async {
    final items = await _dbHelper.getAllExpenseItem();
    _expenseItemLists = items;
    notifyListeners();
  }


  Future<void> addExpenseItem(ExpenseItemModel items) async {
    await _dbHelper.insertExpenseItem(items);
    await loadExpenseItem();
  }


  Future<void> updateItem({
    required int index,
    required double amount,
    required bool isExpense,
  }) async {
    if (isExpense) {
      if(_expenseItemLists[index].balance <= 0){
        return;
      } else {
        _expenseItemLists[index].balance -= amount;
      }

    }else {
      _expenseItemLists[index].balance += amount;
    }
    await _dbHelper.updateExpenseItem(_expenseItemLists[index]);
    notifyListeners();
  }


  Future<void> deleteExpenseItem(String id) async {
    await _dbHelper.deleteExpenseItem(id);
    await loadExpenseItem();
  }




}