import 'package:flutter/material.dart';
import 'package:paywage/CustomTheme/CustomColors.dart';
import 'package:paywage/views/attendance_page.dart';
import 'package:paywage/views/payment_page.dart';

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
Widget BottomNavigation(int index, BuildContext context) {

  int _selectedIndex = index;
    return BottomNavigationBar(
      backgroundColor: CustomColors.paleGreenColour,
      currentIndex: _selectedIndex,
     onTap: (index){

        // if(index == 0){
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> AttendancePage(title: "Paywage")));
        // }else if(index == 1){
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentPage(title: "Paywage")));
        // }
        setState(){
          _selectedIndex = index;
        }
     },
      selectedFontSize: 20,
      selectedIconTheme: IconThemeData(color: Colors.white, size: 25),
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            activeIcon: Icon(Icons.punch_clock_rounded),
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Attendance'),
        BottomNavigationBarItem(
            activeIcon: Icon(Icons.payment_rounded),
            icon: Icon(Icons.payments),
            label: 'Payment'),
      ],
      // unselectedItemColor: Colors.white,
      selectedItemColor: Colors.yellow,

    );
  }
