import 'package:flutter/material.dart';
import 'package:paywage/views/attendance_page.dart';
import 'package:intl/intl.dart';
import 'package:paywage/common/myAppBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:paywage/models/employee.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.title});

  final String title;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<String> employeeList = <String>[];
  int _selectedIndex = 1;
  TextEditingController dateinput = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<TextEditingController> _totalAmount = [];
  List<TextEditingController> _paidAmount = [];
  List<bool> _isSelected = [false, false];

  @override
  void initState() {
    dateinput.text = "";
    this.fetchEmployee();
    super.initState();
  }

  Future getData() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/fetchEmployee.php';
    var response = await http.get(Uri.parse(url), headers: {
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
          employeeList.add(employee[i].firstName + " " + employee[i].lastName);
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
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xff7C8362),
                      prefixIcon: IconButton(
                        icon: Icon(
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
              FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
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
                            _totalAmount.add(new TextEditingController());
                            _totalAmount[index].text = "0";
                            _paidAmount.add(new TextEditingController());

                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              color: Color(0xff31473A),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 0,
                                              top: 0,
                                              right: 15,
                                              bottom: 0),
                                          child: Text(
                                            name,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 75,
                                          height: 35,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xff7C8362),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2.0,
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2.0,
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2.0,
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                            ),

                                            style:
                                                TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center,
                                            controller: _totalAmount[index],
                                            //editing controller of this TextField
                                            readOnly: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 0, top: 0, right: 0, bottom: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                            color: Color(0xff7C8362),
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                          ),
                                          child: ToggleButtons(
                                            color: Colors.white,
                                            selectedColor: Colors.black,
                                            fillColor: Colors.white,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Text(
                                                  "Advance",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Text(
                                                  "Regular",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                            isSelected: _isSelected,
                                            onPressed: (int pos) {
                                              setState(() {
                                                for (int i = 0;
                                                    i < _isSelected.length;
                                                    i++) {
                                                  _isSelected[i] = i == pos;
                                                }
                                              });
                                            },
                                          ),
                                          // ) ,
                                        ),
                                        SizedBox(
                                          width: 150,
                                          height: 50,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xff7C8362),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2.0,
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2.0,
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2.0,
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                            ),

                                            style:
                                                TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center,
                                            controller: _paidAmount[index],
                                            //editing controller of this TextField
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                      : CircularProgressIndicator();
                },
              ),
              Container(
                child: Padding(
                  padding: new EdgeInsets.all(64.0),
                  //onPressed will show login with the username typed on terminal
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff31473A),
                        foregroundColor: Colors.white),
                    onPressed: () {
                      final snackBar = SnackBar(
                        content: Text(
                          'Payment Updated',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Color(0xff31473A),
                        action: SnackBarAction(
                          label: 'dismiss',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: new Text('MAKE PAYMENT'),
                  ),
                ),
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
      ),
    );
  }
}
