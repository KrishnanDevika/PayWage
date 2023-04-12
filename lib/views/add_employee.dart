import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paywage/common/myAppBar.dart';
import 'package:paywage/common/BottomNavigationBar.dart';
import 'package:paywage/views/attendance_page.dart';
import 'package:paywage/models/salary_type.dart';
import 'package:paywage/models/occupation.dart';
import 'package:paywage/models/city.dart';
import 'package:paywage/models/states.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../CustomTheme/CustomColors.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key, required this.title});

  final String title;

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  List<String> wage_type = <String>[];
  List<String> cities = <String>[];
  List<String> states = <String>[];
  List<String> occupationList= <String>[];

  @override
  void initState() {
    this.fetchSalaryType();
    this.fetchCities();
    this.fetchStates();
    this.fetchOccupation();
  }

  Future fetchOccupation() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/fetchOccupation.php';
    try {
      http.Response response = await http.get(Uri.parse(url));
      var data = response.body;
      final parsed = jsonDecode(data).cast<Map<String, dynamic>>();

      final List<Occupation> type =
      parsed.map<Occupation>((json) => Occupation.fromJson(json)).toList();
      for (var i = 0; i < type.length; i++) {
        occupationList.add(type[i].occupation);
        print(type[i].occupation);
      }
    }
    catch(e){
      print(e);
    }
  }

  Future fetchSalaryType() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/wageType.php';
    try {
      http.Response response = await http.get(Uri.parse(url));
      var data = response.body;
      final parsed = jsonDecode(data).cast<Map<String, dynamic>>();

      final List<SalaryType> type =
      parsed.map<SalaryType>((json) => SalaryType.fromJson(json)).toList();
      for (var i = 0; i < type.length; i++) {
        wage_type.add(type[i].type);
        print(type[i].type);
      }
    }
    catch(e){
      print(e);
    }
  }

  Future fetchCities() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/fetchCities.php';
    try {
      http.Response response = await http.get(Uri.parse(url));
      var data = response.body;
      final parsed = jsonDecode(data).cast<Map<String, dynamic>>();

      final List<City> city =
      parsed.map<City>((json) => City.fromJson(json)).toList();
      for (var i = 0; i < city.length; i++) {
        cities.add(city[i].cityName);
        print(city[i].cityName);
      }
    }catch(e){
      print(e);
    }
  }

  Future fetchStates() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/state.php';
    try {
      http.Response response = await http.get(Uri.parse(url));
      var data = response.body;
      final parsed = jsonDecode(data).cast<Map<String, dynamic>>();
      final List<States> state =
      parsed.map<States>((json) => States.fromJson(json)).toList();
      for (var i = 0; i < state.length; i++) {
        states.add(state[i].stateName);
        print(state[i].stateName);
      }
    }
    catch(e){
      print(e);
    }
  }

  String salaryType_value = 'Daily';
  String city_value = 'Delhi';
  String state_value = 'Gujarat';
  String occupation_value = "Wall Protection";
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController occupation = TextEditingController();
 // TextEditingController wageType = TextEditingController();
  TextEditingController baseRate = TextEditingController();

  Future createEmployee() async{
    final response = await http.post(Uri.parse('https://dkrishnan.scweb.ca/Paywage/insertEmployee.php'), body:{
      "first_name": firstName.text,
      "last_name": lastName.text,
      "start_date": startDate.text,
      "phone":contact.text,
      "salary_type": salaryType_value,
      "street": street.text,
      "city": city_value,
      "state": state_value,
      "occupation_type":occupation_value,
      "pay_rate": baseRate.text,
    });

    print((response.body));
  }

  void reset(){
    firstName.clear();
    lastName.clear();
    startDate.clear();
    contact.clear();
    street.clear();
    baseRate.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.title),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const Padding(
                padding:
                    EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 15),
                child: Text(
                  'CREATE NEW EMPLOYEE',
                  style: TextStyle(
                      fontSize: 24,
                      color: CustomColors.paleGreenColour,
                      fontWeight: FontWeight.bold),
                ),
              ),
               Container(
                height: 45,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.paleGreenColour,
                ),
                child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 15, bottom: 10),
                      child: Text(
                        'First Name',
                        style: TextStyle(color: CustomColors.lightModeTextColor, fontSize: 18),
                      ),
                    ),
                     Expanded(
                        child: TextField(
                      style: TextStyle(color: CustomColors.lightModeTextColor),
                      decoration: InputDecoration(
                        fillColor: CustomColors.darkGreenColour,
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
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.paleGreenColour,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 15, bottom: 10),
                      child: Text(
                        'Last Name',
                        style: TextStyle(color: CustomColors.lightModeTextColor, fontSize: 18),
                      ),
                    ),
                     Expanded(
                        child:  TextField(
                      style: TextStyle(color: CustomColors.lightModeTextColor),
                      decoration: InputDecoration(
                        fillColor: CustomColors.darkGreenColour,
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
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.paleGreenColour,
                ),
                child: Row(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 20, bottom: 10),
                      child: Text(
                        'Start Date',
                        style: TextStyle(color: CustomColors.lightModeTextColor, fontSize: 18),
                      ),
                    ),
                     Expanded(
                        child: TextField(
                      style: TextStyle(color: CustomColors.lightModeTextColor),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.calendar_month_sharp,
                          color: CustomColors.lightModeTextColor,
                        ),
                        fillColor: CustomColors.darkGreenColour,
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
                              DateFormat('yyyy-MM-dd').format(date);
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
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.paleGreenColour,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Contact No',
                        style: TextStyle(color: CustomColors.lightModeTextColor, fontSize: 18),
                      ),
                    ),
                     Expanded(
                        child:  TextField(
                      style: TextStyle(color: CustomColors.lightModeTextColor),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '###-###-####',
                        hintStyle: TextStyle(color: CustomColors.lightModeTextColor),
                        fillColor: CustomColors.darkGreenColour,
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
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.paleGreenColour,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 55, bottom: 10),
                      child: Text(
                        'Street',
                        style: TextStyle(color: CustomColors.lightModeTextColor, fontSize: 18),
                      ),
                    ),
                     Expanded(
                        child:  TextField(
                      style: TextStyle(color: CustomColors.lightModeTextColor),
                      decoration: InputDecoration(
                        fillColor: CustomColors.darkGreenColour,
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
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.paleGreenColour,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 70, bottom: 10),
                      child: Text(
                        'City',
                        style: TextStyle(color: CustomColors.lightModeTextColor, fontSize: 18),
                      ),
                    ),
                    Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: CustomColors.darkGreenColour,
                          //background color of dropdown button
                          border: Border.all(color: Colors.black),
                          //border of dropdown button
                          borderRadius: BorderRadius.circular(
                              10), //border radius of dropdown button
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 30),
                          child: DropdownButton(
                            dropdownColor: CustomColors.darkGreenColour,
                            underline: Container(),
                            value: city_value,
                            style: const TextStyle(
                                color: CustomColors.lightModeTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: CustomColors.lightModeTextColor,
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
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.paleGreenColour,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 60, bottom: 10),
                      child: Text(
                        'State',
                        style: TextStyle(color: CustomColors.lightModeTextColor, fontSize: 18),
                      ),
                    ),
                     Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: CustomColors.darkGreenColour,
                          //background color of dropdown button
                          border: Border.all(color: Colors.black),
                          //border of dropdown button
                          borderRadius: BorderRadius.circular(
                              10), //border radius of dropdown button
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 30),
                          child:  DropdownButton(
                            dropdownColor: CustomColors.darkGreenColour,
                            underline: Container(),
                            value: state_value,
                            style: const TextStyle(
                                color: CustomColors.lightModeTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: CustomColors.lightModeTextColor,
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
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.paleGreenColour,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 10, bottom: 10),
                      child: Text(
                        'Occupation',
                        style: TextStyle(color: CustomColors.lightModeTextColor, fontSize: 18),
                      ),
                    ),
                     Expanded(
                      child:  DecoratedBox(
                        decoration: BoxDecoration(
                          color: CustomColors.darkGreenColour,
                          //background color of dropdown button
                          border: Border.all(color: Colors.black),
                          //border of dropdown button
                          borderRadius: BorderRadius.circular(
                              10), //border radius of dropdown button
                        ),

                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: DropdownButton(
                            dropdownColor: CustomColors.darkGreenColour,
                            underline: Container(),
                            value: occupation_value,
                            style: const TextStyle(
                                color: CustomColors.lightModeTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: CustomColors.lightModeTextColor,
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
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.paleGreenColour,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 15, bottom: 10),
                      child: Text(
                        'Wage type',
                        style: TextStyle(color: CustomColors.lightModeTextColor, fontSize: 18),
                      ),
                    ),
                     Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: CustomColors.darkGreenColour,
                          //background color of dropdown button
                          border: Border.all(color: Colors.black),
                          //border of dropdown button
                          borderRadius: BorderRadius.circular(
                              10), //border radius of dropdown button
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 30),
                          child:  DropdownButton(
                            dropdownColor: CustomColors.darkGreenColour,
                            underline: Container(),
                            value: salaryType_value,
                            style: const TextStyle(
                                color: CustomColors.lightModeTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: CustomColors.lightModeTextColor,
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
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CustomColors.paleGreenColour,
                ),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 30, bottom: 10),
                      child: Text(
                        'Wage/hr',
                        style: TextStyle(color: CustomColors.lightModeTextColor, fontSize: 18),
                      ),
                    ),
                     Expanded(
                        child:  TextField(
                      style: TextStyle(color: CustomColors.lightModeTextColor),
                      decoration: InputDecoration(
                        fillColor: CustomColors.darkGreenColour,
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
                padding: EdgeInsets.all(64.0),
                //onPressed will show login with the username typed on terminal
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff31473A),
                      foregroundColor: CustomColors.lightModeTextColor),
                  onPressed: () {
                    createEmployee();
                    final snackBar = SnackBar(
                        content:  Text('Employee Created', style: TextStyle(color: CustomColors.lightModeTextColor),),
                    backgroundColor:  Color(0xff31473A),
                    action: SnackBarAction(
                    label: 'dismiss',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AttendancePage(title: 'Pay Wage')));
                    },
                    ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                   reset();
                  },
                  child: Text('Create Employee'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(0),
    );
  }
}
