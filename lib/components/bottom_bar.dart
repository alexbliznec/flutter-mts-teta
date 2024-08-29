import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final Function(int) bottomBarNavigate;
  final int selectedPage;

  BottomBar({required this.bottomBarNavigate, required this.selectedPage});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper_rounded),
          label: 'News',
        ),
          BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
      ],
      currentIndex: selectedPage,
      onTap: bottomBarNavigate,
      selectedItemColor: Colors.grey[800],
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.grey[300],
    );
  }
}