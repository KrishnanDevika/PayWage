import 'package:flutter/material.dart';
import 'package:paywage/CustomTheme/CustomColors.dart';
import 'package:paywage/views/add_employee.dart';
import 'package:intl/intl.dart';
import 'package:paywage/common/myAppBar.dart';
import 'package:paywage/common/BottomNavigationBar.dart';
import 'package:paywage/models/employee.dart';
import 'package:paywage/models/job_site.dart';
import 'package:paywage/models/occupation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toggle_switch/toggle_switch.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.title});

  final String title;

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<String> employeeList = <String>[];

  int? groupValue;

  bool isSwitched = false;

  TextEditingController dateinput = TextEditingController();
  TextEditingController searchController = TextEditingController();

  int _selectedIndex = 0;



  Future fetchEmployee() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/fetchEmployee.php';
    try {
      http.Response response = await http.get(Uri.parse(url));
      var data = response.body;
      final parsed = jsonDecode(data).cast<Map<String, dynamic>>();

      final List<Employee> employee =
      parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
      for (var i = 0; i < employee.length; i++) {
        employeeList.add(employee[i].firstName +" "+ employee[i].lastName);
        print(employee[i].firstName +" "+ employee[i].lastName);
      }
    }
    catch(e){
      print(e);
    }
  }


  @override
  void initState() {
    dateinput.text = "";
    super.initState();
    this.fetchEmployee();

  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.title, context),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child :Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff7C8362).withOpacity(0.5),
                ),
                margin: const EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      // padding: EdgeInsets.only(left: 130, top: 0, right: 30, bottom: 0),
                      icon: Icon(Icons.arrow_back_ios_new),
                      iconSize: 20,
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          DateFormat inputFormat = DateFormat('dd-MM-yyyy');
                          DateTime date = inputFormat.parse(dateinput.text);
                          DateTime pastDate = date.subtract(Duration(days: 1));
                          if (pastDate != null) {
                            String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pastDate!);
                            dateinput.text = formattedDate;
                          }
                        });
                      },
                    ),
                    SizedBox(
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
                            DateFormat('dd-MM-yyyy').format(date!);
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
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: CustomColors.paleGreenColour,
                      prefixIcon: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: employeeList.length,
                  itemBuilder: (context, index) {

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      color: Color(0xff31473A),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, top: 4, right: 10, bottom: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  employeeList[index],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(width: 40),
                                SizedBox(
                                  width: 80,
                                  height: 40,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: CustomColors.paleGreenColour,
                                      border: Border.all(
                                        width: 2
                                      ),
                                      borderRadius: BorderRadius.circular(13)
                                    ),
                                    child: Center(
                                      child: Text('\$ 100', style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),),
                                  ),
                                )
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30, top: 5, right: 30, bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[

                                ToggleSwitch(
                                  minHeight: 30,
                                  minWidth: 50,
                                  labels: ['adv', 'reg'],
                                  onToggle: (index){
                                    print('$index');
                                  }
                                ),

                                Container(
                                  width: 150,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: CustomColors.paleGreenColour,
                                      border: Border.all(
                                          width: 2
                                      ),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: TextField(

                    style: TextStyle(color: CustomColors.lightModeTextColor, fontSize: 20),
                    decoration: InputDecoration(
                    filled: true,
                    fillColor: CustomColors.paleGreenColour,
                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    )

                    ),
                    ),
                                )

                                // TextField()
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.paleGreenColour,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddEmployeePage(title: 'Pay Wage')));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      bottomNavigationBar: BottomNavigation(0), /*BottomNavigationBar(
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
      ), */ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}