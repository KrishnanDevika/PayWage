import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paywage/common/myAppBar.dart';
import 'package:paywage/views/payment_page.dart';
import 'package:paywage/views/attendance_page.dart';
import 'package:paywage/models/salary_type.dart';
import 'package:paywage/models/occupation.dart';
import 'package:paywage/models/city.dart';
import 'package:paywage/models/states.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateEmployeePage extends StatefulWidget {

  final String title;
  final int index;
  final List list;

  const UpdateEmployeePage(
      {
        super.key,
        required this.title,
        required this.list,
        required this.index,
      });


  @override
  State<UpdateEmployeePage> createState() => _UpdateEmployeePageState();
}

class _UpdateEmployeePageState extends State<UpdateEmployeePage> {
  List<String> wage_type = <String>[];
  List<String> cities = <String>[];
  List<String> states = <String>[];
  List<String> occupationList= <String>[];
  String salaryType_value = 'Daily';
  String city_value = 'Delhi';
  String state_value = 'Gujarat';
  String occupation_value = "Wall Protection";
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController baseRate = TextEditingController();
  int _selectedIndex = 0;

  bool editMode = false;

  Future updateEmployee() async{
    print(widget.list[widget.index]['id']);
    String id = widget.list[widget.index]['id'].toString();
    final response = await http.post(
        Uri.parse('https://dkrishnan.scweb.ca/Paywage/updateEmployee.php'),
        body: {
          'id': id,
          "first_name": firstName.text,
          "last_name": lastName.text,
          "start_date": startDate.text,
          "phone": contact.text,
          "salary_type": salaryType_value,
          "street": street.text,
          "city": city_value,
          "state": state_value,
          "occupation_type": occupation_value,
          "pay_rate": baseRate.text,
        });
   print((response.body));
  }

  @override
  void initState() {
    fetchSalaryType();
    fetchCities();
    fetchStates();
    fetchOccupation();
    editMode = true;
    firstName.text = widget.list[widget.index]['first_name'];
    lastName.text = widget.list[widget.index]['last_name'];
    startDate.text = widget.list[widget.index]['start_date'];
    contact.text = widget.list[widget.index]['phone'];
    street.text = widget.list[widget.index]['street'];
    baseRate.text = '${widget.list[widget.index]['pay_rate']}';
    city_value = widget.list[widget.index]['city'];
    state_value = widget.list[widget.index]['state'];
    salaryType_value = widget.list[widget.index]['salary_type'];
    occupation_value = widget.list[widget.index]['occupation_type'];

    super.initState();
  }

  void fetchOccupation() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/fetchOccupation.php';
    try {
      http.Response response = await http.get(Uri.parse(url));
      var data = response.body;
      final parsed = jsonDecode(data).cast<Map<String, dynamic>>();

      final List<Occupation> type =
      parsed.map<Occupation>((json) => Occupation.fromJson(json)).toList();
      setState(() {
        for (var i = 0; i < type.length; i++) {
          occupationList.add(type[i].occupation);
        }
      });

    }
    catch(e){
      print(e);
    }
  }

  void fetchSalaryType() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/wageType.php';
    try {
      http.Response response = await http.get(Uri.parse(url));
      var data = response.body;
      final parsed = jsonDecode(data).cast<Map<String, dynamic>>();

      final List<SalaryType> type =
      parsed.map<SalaryType>((json) => SalaryType.fromJson(json)).toList();
      setState(() {
        for (var i = 0; i < type.length; i++) {
          wage_type.add(type[i].type);
        }
      });

    }
    catch(e){
      print(e);
    }
  }

  void fetchCities() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/fetchCities.php';
    try {
      http.Response response = await http.get(Uri.parse(url));
      var data = response.body;
      final parsed = jsonDecode(data).cast<Map<String, dynamic>>();

      final List<City> city =
      parsed.map<City>((json) => City.fromJson(json)).toList();
      setState(() {
        for (var i = 0; i < city.length; i++) {
          cities.add(city[i].cityName);
        }
      });

    }catch(e){
      print(e);
    }
  }

  void fetchStates() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/state.php';
    try {
      http.Response response = await http.get(Uri.parse(url));
      var data = response.body;
      final parsed = jsonDecode(data).cast<Map<String, dynamic>>();
      final List<States> state =
      parsed.map<States>((json) => States.fromJson(json)).toList();
      setState(() {
        for (var i = 0; i < state.length; i++) {
          states.add(state[i].stateName);
        }
      });

    }
    catch(e){
      print(e);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch(index){
      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AttendancePage(title: 'PayWage'),),);
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const PaymentPage(title: 'PayWage'),),);

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
            children: <Widget>[
              const Padding(
                padding:
                EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 15),
                child: Text(
                 "UPDATE EMPLOYEE",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xff7C8362),
                      fontWeight: FontWeight.bold),
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
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.calendar_month_sharp,
                              color: Colors.white,
                            ),
                            fillColor: const Color(0xff57654E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
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
                              startDate.text = formattedDate;
                            }
                          },
                          controller: startDate,
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
                            hintText: '###-###-####',
                            hintStyle: const TextStyle(color: Colors.white),
                            fillColor: const Color(0xff57654E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: contact,
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
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color(0xff57654E),
                          //background color of dropdown button
                          border: Border.all(color: Colors.black),
                          //border of dropdown button
                          borderRadius: BorderRadius.circular(
                              10), //border radius of dropdown button
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 30),
                          child: DropdownButton(
                            dropdownColor: const Color(0xff57654E),
                            underline: Container(),
                            value: city_value,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),

                            items: cities.map((String city) {
                              return DropdownMenuItem(
                                value: city,
                                child: Text(
                                  city,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                city_value = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
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
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color(0xff57654E),
                          //background color of dropdown button
                          border: Border.all(color: Colors.black),
                          //border of dropdown button
                          borderRadius: BorderRadius.circular(
                              10), //border radius of dropdown button
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 30),
                          child: DropdownButton(
                            dropdownColor: const Color(0xff57654E),
                            underline: Container(),
                            value: state_value,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                            items: states.map((String state) {
                              return DropdownMenuItem(
                                value: state,
                                child: Text(
                                  state,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                state_value = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    )
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
                          left: 10, top: 10, right: 10, bottom: 10),
                      child: Text(
                        'Occupation',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color(0xff57654E),
                          //background color of dropdown button
                          border: Border.all(color: Colors.black),
                          //border of dropdown button
                          borderRadius: BorderRadius.circular(
                              10), //border radius of dropdown button
                        ),

                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: DropdownButton(
                            dropdownColor: const Color(0xff57654E),
                            underline: Container(),
                            value: occupation_value,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),

                            items: occupationList.map((String occupation) {
                              return DropdownMenuItem(
                                value: occupation,
                                child: Text(
                                  occupation,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                occupation_value = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
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
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color(0xff57654E),
                          //background color of dropdown button
                          border: Border.all(color: Colors.black),
                          //border of dropdown button
                          borderRadius: BorderRadius.circular(
                              10), //border radius of dropdown button
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 30),
                          child:  DropdownButton(
                            dropdownColor: const Color(0xff57654E),
                            underline: Container(),
                            value: salaryType_value,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                            items: wage_type.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                salaryType_value = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
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
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(64.0),
                //onPressed will show login with the username typed on terminal
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff31473A),
                      foregroundColor: Colors.white),
                  onPressed: () {
                    updateEmployee();
                    final snackBar = SnackBar(
                      content:  const Text('Employee Updated', style: TextStyle(color: Colors.white),),
                      backgroundColor:  const Color(0xff31473A),
                      action: SnackBarAction(
                        label: 'dismiss',
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AttendancePage(title: 'PayWage'),
                              ),
                          );
                          //Navigator.pop(context);
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text('UPDATE EMPLOYEE'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:  BottomNavigationBar(
        backgroundColor: const Color(0xff7C8362),
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
