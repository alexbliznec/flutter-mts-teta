import 'package:flutter/material.dart';

class NewsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback toggleTheme;

  NewsAppBar({required this.toggleTheme});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Widget getThemeIcon() {
      return Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode);
    }

    return AppBar(
        title: Text(
          'Actual news',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.grey[300],
        actions: <Widget>[
          IconButton(
            onPressed: () => this.toggleTheme(),
            icon: getThemeIcon(),
          )
        ],
    );
  }
}