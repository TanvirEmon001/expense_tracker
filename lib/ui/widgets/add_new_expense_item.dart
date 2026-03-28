import 'package:flutter/material.dart';
import 'package:track_expense/models/expense_item_model.dart';

class AddNewExpenseItem extends StatefulWidget {
  const AddNewExpenseItem({super.key, required this.onAddItems});

  final void Function(ExpenseItemModel items) onAddItems;

  @override
  State<AddNewExpenseItem> createState() => _AddNewExpenseItemState();
}

class _AddNewExpenseItemState extends State<AddNewExpenseItem> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(context) {
    final keyboardSpaces = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (_, constraints) {
        //final width = constraints.maxWidth; for responsiveness

        return SizedBox(
          height: double.infinity,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 50, 16, keyboardSpaces + 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
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
                          onPressed: _saveItemOnTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                          ),
                          child: const Text("Save Item"),
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

  void _saveItemOnTap() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text.trim());
    final amountIsValid = amount == null || amount <= 0;

    if (title.isEmpty || amountIsValid) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Invalid Input!"),
          content: const Text(
            "Please make sure a valid title, amount, date and category was entered!",
          ),
          actions: [
            FilledButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: const Text("Ok"))
          ],
        ),
      );
      return;
    }
    widget.onAddItems(
      ExpenseItemModel(itemName: title, balance: amount, dateTime: DateTime.now())
    );
    Navigator.of(context).pop();
  }


  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

}
