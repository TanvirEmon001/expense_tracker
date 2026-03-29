import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_expense/provider/add_expense_item_provider.dart';
import 'package:track_expense/provider/update_expense_provider.dart';

class UpdateExpenseItem extends StatefulWidget {
  const UpdateExpenseItem({
    super.key,
    required this.isExpense,
    required this.index
  });

  final bool isExpense;
  final int index;


  @override
  State<UpdateExpenseItem> createState() => _UpdateExpenseItemState();
}

class _UpdateExpenseItemState extends State<UpdateExpenseItem> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final keyboardSpaces = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (_, constraints) {
        return SizedBox(
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 50, 16, keyboardSpaces + 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _noteController,
                    maxLength: 50,
                    textInputAction: .next,
                    decoration: const InputDecoration(label: Text("Title")),
                  ),
                  TextField(
                    controller: _amountController,
                    maxLength: 8,
                    textInputAction: .done,
                    decoration: const InputDecoration(label: Text("Amount")),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _cancelOnTap,
                          child: const Text("Cancel"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _updateBalanceOnTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.isExpense
                                ? Colors.redAccent
                                : Colors.greenAccent,
                          ),
                          child: Text(
                            "Update Balance",
                            style: TextStyle(
                              color: widget.isExpense ? Colors.white : null,
                            ),
                          ),
                        ),
                      ),
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

  void _cancelOnTap() {
    Navigator.of(context).pop();
  }

  void _updateBalanceOnTap() {
    final note = _noteController.text.trim();
    final amount = double.tryParse(_amountController.text.trim());
    final amountIsValid = amount == null || amount <= 0;


    if (note.isEmpty || amountIsValid || amount <= 0) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Invalid Input!"),
          content: const Text(
            "Please make sure a valid title, amount, date and category was entered!",
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );
      return;
    }


    context.read<AddExpenseItemProvider>().updateItem(
      index: widget.index,
      amount: amount,
      isExpense: widget.isExpense,
    );

    Navigator.of(context).pop();
  }
}
