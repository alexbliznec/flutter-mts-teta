import 'package:flutter/material.dart';
import 'package:flutter_projects/components/app_bar.dart';
import 'package:flutter_projects/components/bottom_bar.dart';
import 'package:flutter_projects/pages/news.dart';
import 'package:flutter_projects/pages/search.dart';

class Home extends StatefulWidget {
  final VoidCallback toggleTheme;

  const Home({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  int selectedPage = 0;
  late final VoidCallback toggleTheme;

  final List<Widget> pages = [
    News(),
    SearchPage(),
  ];

  void bottomBarNavigate(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
    toggleTheme = widget.toggleTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewsAppBar(toggleTheme: this.toggleTheme),
      body: pages[selectedPage],
      bottomNavigationBar: BottomBar(
        bottomBarNavigate: this.bottomBarNavigate,
        selectedPage: selectedPage,
      ),
    );
  }
}