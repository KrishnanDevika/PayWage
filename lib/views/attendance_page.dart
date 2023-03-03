
import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key, required this.title});

  final String title;

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {

  void _incrementCounter() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
       leadingWidth: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        title: Text(widget.title,
                    style: TextStyle(color: Color(0xff63684E),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    )),
        leading: Icon(Icons.settings,
                      size: 42,
                      color: Color(0xff7C8362),
                      ),

        actions: [
          Icon(Icons.account_circle,
              size: 42,
              color: Color(0xff7C8362)),
          Padding(padding: EdgeInsets.only(right: 16))
        ],

      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[



          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff7C8362),
         onPressed: _incrementCounter,
        // tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff7C8362),
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
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
