import 'package:flutter/material.dart';

// class BottomNavigation extends StatefulWidget {
//   const BottomNavigation({super.key});
//
//
//
// @override
// State<BottomNavigation> createState() => _BottomNavigationState();
// }
//
// class _BottomNavigationState extends State<BottomNavigation> {
//
//   int _selectedIndex = 0;
//
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
Widget BottomNavigation(int index) {

  int _selectedIndex = index;
    return BottomNavigationBar(
      backgroundColor: Color(0xff7C8362),
      currentIndex: _selectedIndex,
     onTap: (index){
        setState(){
          _selectedIndex = index;
        }
     },
      selectedFontSize: 20,
      selectedIconTheme: IconThemeData(color: Colors.white, size: 25),
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            activeIcon: Icon(Icons.punch_clock_rounded),
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Attendance'),
        BottomNavigationBarItem(
            activeIcon: Icon(Icons.payment_rounded),
            icon: Icon(Icons.payments),
            label: 'Payment'),
      ],
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.white,

    );
  }
