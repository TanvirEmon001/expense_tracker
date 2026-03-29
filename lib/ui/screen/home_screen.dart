import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_expense/models/expense_item_model.dart';
import 'package:track_expense/provider/add_expense_item_provider.dart';
import 'package:track_expense/ui/screen/expense_item_details_screen.dart';
import 'package:track_expense/ui/widgets/add_new_expense_item.dart';

import '../../provider/update_expense_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


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
          child: Consumer<AddExpenseItemProvider>(
            builder: (_,provider,_) {
              return ListView.builder(
                itemCount: provider.expenseItemLists.length,
                itemBuilder: (_, index) {
                  final eachItem = provider.expenseItemLists[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              ExpenseItemDetailsScreen(index: index,),
                        ),
                      );
                    },
                    child: Card(
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
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.menu),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Text("Balance: ${eachItem.balance.toStringAsFixed(0)}"),
                                const Spacer(),
                                Text(
                                  eachItem.formattedDate,
                                ), //"04-02-2026, 11:45AM"
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          ),
        ),
      ),
    );
  }

  void _addButtonOnTap() {
    showModalBottomSheet(
      context: context,
      builder: (_) => AddNewExpenseItem(),
    );
  }


}
