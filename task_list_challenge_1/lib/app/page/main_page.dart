import 'package:flutter/material.dart';
import 'package:task_list_challenge_1/app/page/progess_bar_page.dart';
import 'package:task_list_challenge_1/app/pages/task_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _position = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _position = value;
                });
              },
              children: const [
                TaskPage(),
                ProgressBarPage(),
              ],
            ),
          ),
          BottomNavigationBar(
              onTap: (value) {
                _pageController.jumpToPage(value);
              },
              type: BottomNavigationBarType.fixed,
              currentIndex: _position,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.graphic_eq), label: "Progress")
              ])
        ],
      ),
    );
  }
}
