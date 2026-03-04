import 'package:flutter/material.dart';
import 'package:track_expense/app/app_theme.dart';
import 'package:track_expense/ui/screen/bottom_nav_holder_screen.dart';


class ExpenseTrackerApp extends StatelessWidget{
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const BottomNavHolderScreen(),
    );
  }

}