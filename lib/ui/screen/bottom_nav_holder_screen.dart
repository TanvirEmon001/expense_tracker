import 'package:flutter/material.dart';
import 'package:track_expense/ui/screen/home_screen.dart';

class BottomNavHolderScreen extends StatefulWidget {
  const BottomNavHolderScreen({super.key});

  @override
  State<BottomNavHolderScreen> createState() => _BottomNavHolderScreenState();
}

class _BottomNavHolderScreenState extends State<BottomNavHolderScreen> {

  var _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SizedBox(child: Center(child: Text("Settings Screen"),),)
  ];


  void _selectScreen(int index){
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
