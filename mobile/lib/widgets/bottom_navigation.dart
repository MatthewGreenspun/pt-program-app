import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int idx;
  final void Function(int) onTap;
  const BottomNavigation({super.key, required this.idx, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      currentIndex: idx,
      onTap: onTap,
      selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
      unselectedItemColor: Colors.grey,
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
