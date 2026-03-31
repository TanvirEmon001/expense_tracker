import 'package:flutter/foundation.dart';
import 'package:track_expense/database/database_helper.dart';
import 'package:track_expense/models/balance_item_model.dart';

class BalanceItemProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<BalanceItemModel> _items = [];
  List<BalanceItemModel> get items => _items;


  Future<void> loadBalanceItem(String itemId) async {
    final item = await _dbHelper.getBalanceItemById(itemId);
    _items = item;
    notifyListeners();
  }


  Future<void> addBalanceItem(BalanceItemModel balanceItem) async {
    await _dbHelper.insertBalanceItem(balanceItem);
    await loadBalanceItem(balanceItem.itemId);
  }





}