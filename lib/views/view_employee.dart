import 'package:flutter/material.dart';
import 'package:paywage/common/myAppBar.dart';
import 'package:paywage/views/payment_page.dart';
import 'package:paywage/views/attendance_page.dart';
import 'package:paywage/views/update_employee.dart';
import 'package:paywage/models/employee.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewEmployeePage extends StatefulWidget {

  final String title;
  final int index;
  final List list;

  const ViewEmployeePage(
      {
        super.key,
        required this.title,
        required this.list,
        required this.index,
      });

  @override
  State<ViewEmployeePage> createState() => _ViewEmployeePageState();
}

class _ViewEmployeePageState extends State<ViewEmployeePage> {

  List<String> employeeList = <String>[];
  int _selectedIndex = 0;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController baseRate = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController wageType = TextEditingController();
  TextEditingController occupation = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
    firstName.text = widget.list[widget.index]['first_name'];
    lastName.text = widget.list[widget.index]['last_name'];
    startDate.text = widget.list[widget.index]['start_date'];
    contact.text = widget.list[widget.index]['phone'];
    street.text = widget.list[widget.index]['street'];
    baseRate.text = '${widget.list[widget.index]['pay_rate']}';
    city.text = widget.list[widget.index]['city'];
    state.text = widget.list[widget.index]['state'];
    wageType.text = widget.list[widget.index]['salary_type'];
   occupation.text = widget.list[widget.index]['occupation_type'];
  }

  Future getData() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/fetchEmployee.php';
    var response = await http.get(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });
    return json.decode(response.body);
  }

  void fetchEmployee() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/fetchEmployee.php';
    try {
      http.Response response = await http.get(Uri.parse(url));
      var data = response.body;
      final parsed = jsonDecode(data).cast<Map<String, dynamic>>();

      final List<Employee> employee =
      parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
      setState(() {
        for (var i = 0; i < employee.length; i++) {
          employeeList.add("${employee[i].firstName} ${employee[i].lastName}");
        }

      });
    } catch (e) {
      print(e);
    }
  }
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
        appBar: myAppBar(widget.title, context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const Padding(
                padding:
                EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 15),
                child: Text(
                  "EMPLOYEE PROFILE",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xff7C8362),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 45,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 15, bottom: 10),
                      child: Text(
                        'First Name',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: const Color(0xff57654E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: firstName,
                          readOnly: true,
                        ))
                  ],
                ),
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 15, bottom: 10),
                      child: Text(
                        'Last Name',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: const Color(0xff57654E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: lastName,
                          readOnly: true,
                        ))
                  ],
                ),
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 20, bottom: 10),
                      child: Text(
                        'Start Date',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(

                            fillColor: Color(0xff57654E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: startDate,
                          readOnly: true,
                        ))
                  ],
                ),
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Contact No',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            fillColor: const Color(0xff57654E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: contact,
                          readOnly: true,
                        ))
                  ],
                ),
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 55, bottom: 10),
                      child: Text(
                        'Street',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: const Color(0xff57654E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: street,
                          readOnly: true,
                        ))
                  ],
                ),
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 70, bottom: 10),
                      child: Text(
                        'City',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: const Color(0xff57654E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: city,
                          readOnly: true,
                        ))
                  ],
                ),
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 60, bottom: 10),
                      child: Text(
                        'State',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Color(0xff57654E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: state,
                          readOnly: true,
                        ))
                  ],
                ),
              ),
              Container(
                height: 45,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 10, bottom: 10),
                      child: Text(
                        'Occupation',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: const Color(0xff57654E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: occupation,
                          readOnly: true,
                        ))
                  ],
                ),
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 15, bottom: 10),
                      child: Text(
                        'Wage type',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Color(0xff57654E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: wageType,
                          readOnly: true,
                        ))
                  ],
                ),
              ),
              Container(
                height: 45,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 30, bottom: 10),
                      child: Text(
                        'Wage/hr',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: const Color(0xff57654E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: baseRate,
                          readOnly: true,
                        ))
                  ],
                ),
              ),

            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff7C8362),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (context) =>
                  UpdateEmployeePage(
                      title: 'Pay Wage',
                      list: widget.list,
                      index: widget.index)))
              .then((value) => setState(() {
                getData();
          }));
        },
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar:  BottomNavigationBar(
        backgroundColor: Color(0xff7C8362),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 20,
        selectedIconTheme: const IconThemeData(color: Colors.white, size: 25),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
      ),
    );
  }
}