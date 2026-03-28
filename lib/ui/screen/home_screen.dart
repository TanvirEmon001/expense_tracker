import 'package:flutter/material.dart';
import 'package:track_expense/models/expense_item_model.dart';
import 'package:track_expense/ui/widgets/add_new_expense_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ExpenseItemModel> _items = [
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

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Items"),
        actions: [
          IconButton(onPressed: _addButtonOnTap, icon: const Icon(Icons.add)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
          child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (_, index) {
              final eachItem = _items[index];
              return Card(
                elevation: 5,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              eachItem.itemName.toString(),
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(fontWeight: .bold),
                            ),
                          ),
                          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                        ],
                      ),

                      Row(
                        children: [
                          Text("Balance: ${eachItem.balance}"),
                          const Spacer(),
                          Text(eachItem.formattedDate), //"04-02-2026, 11:45AM"
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _addButtonOnTap() {
    showModalBottomSheet(
      context: context,
      builder: (_) => AddNewExpenseItem(onAddItems: _addExpenseItem),
    );
  }

  void _addExpenseItem(ExpenseItemModel items) {
    setState(() {
      _items.add(items);
    });
  }
}
