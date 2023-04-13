import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paywage/views/attendance_page.dart';
import 'package:paywage/views/payment_page.dart';
import 'package:paywage/common/myAppBar.dart';
import 'package:paywage/views/view_attendance_history.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchEmployeePage extends StatefulWidget {
  const SearchEmployeePage(
      {super.key, required this.title, required this.name});

  final String title;
  final String name;

  @override
  State<SearchEmployeePage> createState() => _SearchEmployeePageState();
}

class _SearchEmployeePageState extends State<SearchEmployeePage> {

  TextEditingController dateinput = TextEditingController();
  List<TextEditingController> _timeinput = [];
  List<TextEditingController> _timeOut = [];
  List<TextEditingController> _site = [];
  List<TextEditingController> _occupation = [];
  int _selectedIndex = 0;
  List<String> textValue = <String>[];
  List<bool> _isChecked = [];
  TextEditingController searchController = TextEditingController();


  Future fetchEmployeeByName() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/fetchEmployeebySearch.php';

    final res = await http.post(Uri.parse(url), body: {
      'first_name': widget.name,
    });

    return json.decode(res.body);

  }



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AttendancePage(title: 'PayWage'),
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PaymentPage(title: 'PayWage'),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.title),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff7C8362).withOpacity(0.5),
                ),
                margin: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new IconButton(
                      // padding: EdgeInsets.only(left: 130, top: 0, right: 30, bottom: 0),
                      icon: Icon(Icons.arrow_back_ios_new),
                      iconSize: 20,
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          DateFormat inputFormat = DateFormat('yyyy-MM-dd');
                          DateTime date = inputFormat.parse(dateinput.text);
                          DateTime pastDate = date.subtract(Duration(days: 1));
                          if (pastDate != null) {
                            String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pastDate!);
                            dateinput.text = formattedDate;
                          }
                        });

                        Navigator.of(context)
                            .push(MaterialPageRoute(
                            builder: (context) => ViewAttendanceHistory(title: 'Pay Wage', date: dateinput.text)));
                      },
                    ),
                    new SizedBox(
                      width: 120,
                      child: TextField(
                        textAlign: TextAlign.center,
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
                  ],
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: searchController,
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xff7C8362),
                      prefixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                              builder: (context) => SearchEmployeePage(title: 'Pay Wage', name: searchController.text)));

                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                ),
              ),
              FutureBuilder(
                future: fetchEmployeeByName(),
                builder: (context, snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          List list = snapshot.data;
                          String name = list[index]['first_name'] +
                              ' ' +
                              list[index]['last_name'];
                          _timeOut.add(new TextEditingController());
                          _timeinput.add(new TextEditingController());
                          _site.add(new TextEditingController());
                          _occupation.add(new TextEditingController());

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
                            color: Color(0xff31473A),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    list[index]['date'],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
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
                                        activeColor: Color(0xff7C8362),
                                        activeTrackColor: Colors.white,
                                        inactiveThumbColor:
                                        Color(0xff7C8362),
                                        inactiveTrackColor:
                                        Color(0xff7C8362)
                                            .withOpacity(0.5),
                                        onChanged: (val) {
                                        },
                                      ),
                                      Text(textValue[index],
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight:
                                              FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 30,
                                      top: 0,
                                      right: 30,
                                      bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Text(
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
                                            fillColor: Color(0xff7C8362),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                          ),


                                          style: TextStyle(
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                          controller: _timeinput[index],
                                          //editing controller of this TextField
                                          readOnly: true,
                                        ),
                                      ),
                                      SizedBox(width: 10),

                                      Text(
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
                                            fillColor: Color(0xff7C8362),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                            ),
                                          ),

                                          style: TextStyle(
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
                                  padding: EdgeInsets.only(
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
                                            fillColor: Color(0xff7C8362),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  15.0),
                                            ),
                                          ),

                                          style: TextStyle(
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                          controller: _site[index],
                                          //editing controller of this TextField
                                          readOnly: true,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      SizedBox(
                                        width: 150,
                                        height: 40,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color(0xff7C8362),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  15.0),
                                            ),
                                          ),

                                          style: TextStyle(
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
                        })
                        : CircularProgressIndicator();
                },
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff7C8362),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 20,
        selectedIconTheme: IconThemeData(color: Colors.white, size: 25),
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
