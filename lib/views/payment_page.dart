import 'package:flutter/material.dart';
import 'package:paywage/views/attendance_page.dart';
import 'package:intl/intl.dart';
import 'package:paywage/common/myAppBar.dart';
class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.title});

  final String title;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch(index){
      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AttendancePage(title: 'PayWage'),),);
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PaymentPage(title: 'PayWage'),),);
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(widget.title),
        body: Text('Payment'),

        bottomNavigationBar:  BottomNavigationBar(
          backgroundColor: Color(0xff7C8362),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
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
        ),
    );
  }
}