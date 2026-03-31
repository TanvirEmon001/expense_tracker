import 'package:flutter/foundation.dart';
import 'package:track_expense/models/balance_item_model.dart';

class BalanceItemProvider extends ChangeNotifier {
  final List<BalanceItemModel> _items = [];
  List<BalanceItemModel> get items => _items;

  void addBalanceItem(BalanceItemModel balanceItem){
    _items.add(balanceItem);
    notifyListeners();
  }

  List<BalanceItemModel> getItemsById(String itemId) {
    return _items.where((item) => item.itemId == itemId).toList();
  }




}