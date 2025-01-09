import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';  
import 'package:dtt/Information Page.dart';
import 'package:dtt/Overview Screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    OverviewScreen(),
    InformationScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.transparent,  
        unselectedItemColor: Colors.transparent,  
        backgroundColor: Color(0xFFFFFFFF),  
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/Icons/ic_home.svg',
              width: 24,             
              height: 24,
              color: _currentIndex == 0 ? Color(0xFFCC000000) : Color(0xFF33000000), 
            ),
            label: '', 
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/Icons/ic_info.svg', 
              width: 24,              
              height: 24,
              color: _currentIndex == 1 ? Color(0xFFCC000000) : Color(0xFF33000000), 
            ),
            label: '', 
          ),
        ],
      ),
    );
  }
}
