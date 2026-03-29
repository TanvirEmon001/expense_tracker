import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:track_expense/app/app.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('en');
  runApp(const ExpenseTrackerApp());
}