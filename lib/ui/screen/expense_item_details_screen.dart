import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_expense/provider/add_expense_item_provider.dart';

import 'package:track_expense/ui/widgets/update_expense_item.dart';

class ExpenseItemDetailsScreen extends StatefulWidget {
  const ExpenseItemDetailsScreen({super.key, required this.index});

  final int index;

  @override
  State<ExpenseItemDetailsScreen> createState() =>
      _ExpenseItemDetailsScreenState();
}

class _ExpenseItemDetailsScreenState extends State<ExpenseItemDetailsScreen> {
  bool isExpense = false;

  @override
  Widget build(BuildContext context) {
    final item = context
        .watch<AddExpenseItemProvider>()
        .expenseItemLists[widget.index];
    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background to make the card pop
      appBar: AppBar(
        title: Text(item.itemName),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Balance",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "৳${item.balance.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _addExpenseOnTap,
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              size: 18,
                            ),
                            label: const Text("Add Expense"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent[700],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _addMoneyOnTap,
                            icon: const Icon(Icons.add, size: 18),
                            label: const Text("Add Money"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addMoneyOnTap() => _showTransactionModal(expenseMode: false);
  void _addExpenseOnTap() => _showTransactionModal(expenseMode: true);

  void _showTransactionModal({required bool expenseMode}) {
    showModalBottomSheet(
      context: context,
      builder: ((_) =>
          UpdateExpenseItem(isExpense: expenseMode, index: widget.index)),
    );
  }
}
