import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatelessWidget {
  final StatefulNavigationShell _navigationShell;
  const MainPage({super.key, required StatefulNavigationShell navigationShell})
      : _navigationShell = navigationShell;

  void _onTap(int index) {
    _navigationShell.goBranch(
      index,
      initialLocation: index == _navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        fixedColor: Colors.amber,
        backgroundColor: Colors.green,
        unselectedItemColor: Colors.white,
        selectedFontSize: 16,
        unselectedFontSize: 16,
        elevation: 20,
        onTap: _onTap,
        // type: BottomNavigationBarType.fixed,
        currentIndex: _navigationShell.currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.graphic_eq), label: "Progress")
        ],
      ),
    );
  }
}
