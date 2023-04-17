import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paywage/common/myAppBar.dart';
import 'package:paywage/views/attendance_page.dart';
import 'package:paywage/views/payment_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewAttendanceHistory extends StatefulWidget {
  const ViewAttendanceHistory(
      {super.key, required this.title, required this.date});

  final String title;
  final String date;

  @override
  State<ViewAttendanceHistory> createState() => _ViewAttendanceHistoryState();
}

class _ViewAttendanceHistoryState extends State<ViewAttendanceHistory> {

  TextEditingController dateinput = TextEditingController();
  final List<TextEditingController> _timeinput = [];
  final List<TextEditingController> _timeOut = [];
  final List<TextEditingController> _site = [];
  final List<TextEditingController> _occupation = [];
  int _selectedIndex = 0;
  List<String> textValue = <String>[];
  final List<bool> _isChecked = [];

  Future fetchAttendance() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/fetchAttendance.php';
    final res = await http.post(Uri.parse(url), body: {
      'date': widget.date,
    });
    return json.decode(res.body);
  }

  @override
  void initState() {
    dateinput.text = widget.date;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AttendancePage(title: 'PayWage'),
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PaymentPage(title: 'PayWage'),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.title, context),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff7C8362).withOpacity(0.5),
                ),
                margin: const EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      // padding: EdgeInsets.only(left: 130, top: 0, right: 30, bottom: 0),
                      icon: const Icon(Icons.arrow_back_ios_new),
                      iconSize: 20,
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          DateFormat inputFormat = DateFormat('yyyy-MM-dd');
                          DateTime date = inputFormat.parse(dateinput.text);
                          DateTime pastDate = date.subtract(const Duration(days: 1));
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pastDate!);
                          dateinput.text = formattedDate;

                          if(dateinput.text.compareTo('2023-04-11') < 0){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ViewAttendanceHistory(
                                    title: 'Pay Wage', date: '2023-04-11')));
                          }else{
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewAttendanceHistory(
                                    title: 'Pay Wage', date: dateinput.text)));
                          }
                        });
                        
                      },
                    ),
                    SizedBox(
                      width: 120,
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                        controller: dateinput,

                        //editing controller of this TextField
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          final DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                          );

                          if (date != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(date!);
                            dateinput.text = formattedDate;
                          }
                        },
                      ),
                    ),

                    IconButton(
                      // padding: EdgeInsets.only(left: 130, top: 0, right: 30, bottom: 0),
                      icon: const Icon(Icons.arrow_forward_ios),
                      iconSize: 20,
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          DateFormat inputFormat = DateFormat('yyyy-MM-dd');
                          DateTime date = inputFormat.parse(dateinput.text);
                          DateTime pastDate = date.add(const Duration(days: 1));
                          String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pastDate!);
                          dateinput.text = formattedDate;

                          if(((DateFormat('yyyy-MM-dd').format(pastDate)).compareTo(DateFormat('yyyy-MM-dd').format(DateTime.now()))  == 0) || pastDate.isAfter(DateTime.now())){
                            String formattedDate =
                            DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 1)));
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewAttendanceHistory(
                                    title: 'Pay Wage', date: formattedDate)));
                          }else{
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewAttendanceHistory(
                                    title: 'Pay Wage', date: dateinput.text)));
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: fetchAttendance(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    if(snapshot.data != null){
                      return  ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            List list = snapshot.data;
                            String name = list[index]['first_name'] +
                                ' ' +
                                list[index]['last_name'];
                            _timeOut.add(TextEditingController());
                            _timeinput.add(TextEditingController());
                            _site.add(TextEditingController());
                            _occupation.add(TextEditingController());

                            _timeinput[index].text = list[index]['start_time'];
                            _timeOut[index].text =list[index]['end_time'];
                            _site[index].text = list[index]['site_name'];
                            _occupation[index].text = list[index]['occupation_type'];


                            if(list[index]['present'] == 'true') {
                              _isChecked.add(true);
                              textValue.add('Present');
                            }else{
                              _isChecked.add(false);
                              textValue.add('Absent');
                            }


                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              color: const Color(0xff31473A),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      name,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        top: 0,
                                        right: 10,
                                        bottom: 2),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Switch(
                                          value: _isChecked[index],
                                          activeColor: const Color(0xff7C8362),
                                          activeTrackColor: Colors.white,
                                          inactiveThumbColor:
                                          const Color(0xff7C8362),
                                          inactiveTrackColor:
                                          const Color(0xff7C8362)
                                              .withOpacity(0.5),
                                          onChanged: (val) {
                                          },
                                        ),
                                        Text(textValue[index],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30,
                                        top: 0,
                                        right: 30,
                                        bottom: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        const Text(
                                          "In",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),

                                        SizedBox(
                                          width: 100,
                                          height: 40,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: const Color(0xff7C8362),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    20.0),
                                              ),
                                            ),


                                            style: const TextStyle(
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                            controller: _timeinput[index],
                                            //editing controller of this TextField
                                            readOnly: true,
                                          ),
                                        ),
                                        const SizedBox(width: 10),

                                        const Text(
                                          "Out",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          width: 100,
                                          height: 40,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: const Color(0xff7C8362),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    20.0),
                                              ),
                                            ),

                                            style: const TextStyle(
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                            controller: _timeOut[index],
                                            //editing controller of this TextField
                                            readOnly: true,
                                          ),
                                        ),
                                        // TextField()
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10,
                                        top: 10,
                                        right: 10,
                                        bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 150,
                                          height: 40,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: const Color(0xff7C8362),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    15.0),
                                              ),
                                            ),

                                            style: const TextStyle(
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                            controller: _site[index],
                                            //editing controller of this TextField
                                            readOnly: true,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          width: 150,
                                          height: 40,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: const Color(0xff7C8362),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    15.0),
                                              ),
                                            ),

                                            style: const TextStyle(
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                            controller: _occupation[index],
                                            //editing controller of this TextField
                                            readOnly: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),

                            );
                          });
                         // : CircularProgressIndicator();
                    } else{
                      return const Text("No widget to build");
                    }


                  }
                 else
                 {
                    return const Center(
                      child: Text(
                        'No Data Found',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    );
                  }


                },
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff7C8362),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 20,
        selectedIconTheme: const IconThemeData(color: Colors.white, size: 25),
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
