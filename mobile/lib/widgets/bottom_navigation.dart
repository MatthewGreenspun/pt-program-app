import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIdx = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.grey[900],
      currentIndex: _selectedIdx,
      onTap: (value) => setState(() {
        _selectedIdx = value;
      }),
      selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
      unselectedItemColor: const Color.fromARGB(255, 172, 172, 172),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.group), label: "Patients"),
        BottomNavigationBarItem(
            icon: Icon(Icons.sports_gymnastics), label: "Exercises"),
        BottomNavigationBarItem(icon: Icon(Icons.view_list), label: "Programs"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}
