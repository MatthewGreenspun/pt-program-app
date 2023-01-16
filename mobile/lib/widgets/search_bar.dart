import "package:flutter/material.dart";

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const SearchBar({super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[900],
      title: const ListTile(
        leading: Icon(Icons.search),
        title: TextField(
          decoration: InputDecoration(label: Text("Search")),
        ),
      ),
    );
  }
}
