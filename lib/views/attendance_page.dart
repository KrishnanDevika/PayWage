
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key, required this.title});

  final String title;

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }


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
      body:  Padding(
        padding: const EdgeInsets.only(left: 0.0, top: 10.0, right: 0.0, bottom: 10.0),
      child: Container(

        color: Color(0xff7C8362).withOpacity(0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              iconSize: 20,
              color: Colors.white,
              onPressed: () {
                setState(() {
                });
              },
            ),

        new Flexible(
            child : TextField(

              style: TextStyle(color: Colors.white),
                controller: dateinput,
                //editing controller of this TextField
                readOnly: true,
              //set it true, so that user will not able to edit text
               onTap: () async {
                 final DateTime? date = await showDatePicker(
                   context: context,
                   initialDate: DateTime.now(),
                   firstDate: DateTime.now(),
                   lastDate: DateTime.now().add(const Duration(days: 365)),
                   initialEntryMode: DatePickerEntryMode.calendarOnly,
                 );

                 if(date != null) {
                   dateinput.text = DateFormat.yMd().format(date!);
                 }
               },
            ),
        ),
          ],
        ),
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

