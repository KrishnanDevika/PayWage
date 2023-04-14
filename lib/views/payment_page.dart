import 'package:flutter/material.dart';
import 'package:paywage/views/attendance_page.dart';
import 'package:intl/intl.dart';
import 'package:paywage/common/myAppBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:paywage/models/employee.dart';
import 'package:paywage/models/pay_type.dart';
import 'package:paywage/models/attendance.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.title});

  final String title;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<int> employeeList = <int>[];
  int _selectedIndex = 1;
  TextEditingController dateinput = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<TextEditingController> _totalAmount = [];
  List<TextEditingController> _paidAmount = [];
  List<bool> _isSelected = [false, false];
  List<List<bool>> _isToggle = <List<bool>>[];
  List<String> pay_type = <String>[];
  List<String> selectedPayType = <String>[];
  List<int> daysWorked = <int>[];
  List<int> payAmount = <int>[];
  List<String> firstname = <String>[];
  List<String> lastName = <String>[];

  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDate =
    DateFormat('yyyy-MM-dd').format(now);
    dateinput.text = formattedDate;
    this.fetchEmployee();
    this.fetchPayType();
    super.initState();
  }

  void fetchPayType() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/fetchPayType.php';
    try {
      http.Response response = await http.get(Uri.parse(url));
      var data = response.body;
      final parsed = jsonDecode(data).cast<Map<String, dynamic>>();

      final List<PayType> type =
          parsed.map<PayType>((json) => PayType.fromJson(json)).toList();
      setState(() {
        for (var i = 0; i < type.length; i++) {
          pay_type.add(type[i].type);
        }
      });
    } catch (e) {

    }
  }

  void fetchEmployee() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/calculatePay.php';
    try {
      http.Response response = await http.get(Uri.parse(url));
      var data = response.body;
      final parsed = jsonDecode(data).cast<Map<String, dynamic>>();

      final List<Attendance> list =
          parsed.map<Attendance>((json) => Attendance.fromJson(json)).toList();
      setState(() {
        for (var i = 0; i < list.length; i++) {
          employeeList.add(list[i].empId);
        }
      });
    } catch (e) {

    }
  }

  Future getData() async {

    var url = 'https://dkrishnan.scweb.ca/Paywage/calculatePay.php';
    try {
      var response = await http.get(Uri.parse(url));
      return json.decode(response.body);
    }
    catch(e){
      print(e);
    }
  }

  Future insertPayment(String fName, String lName, String date, String payType,
      double amount) async {
    final response = await http.post(
        Uri.parse('https://dkrishnan.scweb.ca/Paywage/insertPayment.php'),
        body: {
          "first_name": fName,
          "last_name": lName,
          "date": date,
          "pay_type": payType,
          "payment_amount": amount.toString(),
        });

    print((response.body));
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
              FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if(snapshot.hasError) print(snapshot.error);
              /*  if(!snapshot.hasData){
                return Center(child: Text('No Employee data Found', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),);
                }*/
              //  else {
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

                        if(list[index]['salary_type'] == 2 ){
                          int end = int.parse(list[index]['end_time']
                              .replaceAll(RegExp(r'[^0-9]'), ''));
                          int start = int.parse(list[index]['start_time']
                              .replaceAll(RegExp(r'[^0-9]'), ''));
                          int diff = end - start;
                          print("Time Diff ${diff}");
                          int pay = list[index]['pay_rate'];
                          double amount = ((diff / 100) * pay * list[index]['WorkedDays']);
                          print("AMount ${amount.round()}");
                          _totalAmount[index].text = '\u0024 ${amount.round()}';
                        }


                       if (list[index]['salary_type'] == 2 && list[index]['payment_amount']!= null) {
                          int remainingBalance = (int.parse(list[index]['payment_amount'].replaceAll(RegExp(r'[^0-9/-]'), '')));
                          print(" Remaining ${remainingBalance/100}");
                          int end = int.parse(list[index]['end_time']
                              .replaceAll(RegExp(r'[^0-9]'), ''));
                          int start = int.parse(list[index]['start_time']
                              .replaceAll(RegExp(r'[^0-9]'), ''));
                          int diff = end - start;
                          print("Time Diff ${diff}");
                          int pay = list[index]['pay_rate'];
                           double amount = ((diff / 100) * pay * (list[index]['WorkedDays'] - 1)) + (remainingBalance)/100;
                          print("AMount ${amount.round()}");
                          _totalAmount[index].text = '\u0024 ${amount.round()}';
                        }


                        if(list[index]['salary_type'] == 1){
                          {
                            _totalAmount[index].text =
                            '\u0024 ${(list[index]['WorkedDays'] *
                                list[index]['pay_rate'] )}';
                          }
                        }
                      if(list[index]['salary_type'] == 1 && list[index]['payment_amount']!= null) {
                          int remainingBalance = (int.parse(list[index]['payment_amount'].replaceAll(RegExp(r'[^0-9/-]'), '')));
                          print(" Remaining ${remainingBalance/100}");
                          _totalAmount[index].text =
                          '\u0024 ${((list[index]['WorkedDays'] - 1) *

                              list[index]['pay_rate'] )+ (remainingBalance)/100}';
                        }

                        _paidAmount.add(new TextEditingController());
                        for (int i = 0; i < list.length; i++) {
                          firstname.add(list[i]['first_name']);
                          lastName.add(list[i]['last_name']);
                          selectedPayType.add("Regular");
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
                                      width: 100,
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
                                    /*  new Expanded(
                                          child:*/
                                    new DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Color(0xff7C8362),
                                        //background color of dropdown button
                                        border:
                                        Border.all(color: Colors.white),
                                        //border of dropdown button
                                        borderRadius: BorderRadius.circular(
                                            10), //border radius of dropdown button
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: DropdownButton(
                                          dropdownColor: Color(0xff7C8362),
                                          underline: Container(),
                                          value: selectedPayType[index],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.white,
                                          ),
                                          items:
                                          pay_type.map((String type) {
                                            return DropdownMenuItem(
                                              value: type,
                                              child: Text(
                                                type,
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedPayType[index] =
                                              newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    //  ),

                                    /*   Container(
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

                                            isSelected: _isToggle[index],
                                            onPressed: (int pos) {
                                              setState(() {
                                                print(_isToggle.length);
                                                print(index);
                                                print(pos);
                                             for (int i = 0; i < _isToggle[index].length; i++) {
                                                  _isToggle[index][i] = i == pos;
                                                }
                                              });
                                            },
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
                                          ),
                                          // ) ,
                                        ),*/
                                    SizedBox(
                                      width: 180,
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
              //  }
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
                      for (int index = 0;
                          index < employeeList.length;
                          index++) {

                        double pendingAmount = 0;
                        if (selectedPayType[index] == "Regular") {
                          print(double.parse(_totalAmount[index]
                              .text
                              .replaceAll(RegExp(r'[^0-9/./-]'), '')) );
                          pendingAmount = double.parse(_totalAmount[index]
                                  .text
                                  .replaceAll(RegExp(r'[^0-9/./-]'), '')) -
                              double.parse(_paidAmount[index]
                                  .text
                                  .replaceAll(RegExp(r'[^0-9/./-]'), ''));
                        }
                        if (selectedPayType[index] == "Advance") {
                          print(double.parse(_totalAmount[index]
                              .text
                              .replaceAll(RegExp(r'[^0-9/./-]'), '')) );
                          pendingAmount = double.parse(_totalAmount[index]
                                  .text
                                  .replaceAll(RegExp(r'[^0-9/./-]'), '')) -
                              double.parse(_paidAmount[index]
                                  .text
                                  .replaceAll(RegExp(r'[^0-9/./-]'), ''));
                        }

                        insertPayment(
                            firstname[index],
                            lastName[index],
                            dateinput.text,
                            selectedPayType[index],
                            pendingAmount);

                      }
                      final snackBar = SnackBar(
                        content: Text(
                          'Payment Updated',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Color(0xff31473A),
                        action: SnackBarAction(
                          label: 'dismiss',
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                builder: (context) => PaymentPage(title: 'Pay Wage')))
                                .then((value) => setState(() {
                              getData();
                              employeeList = [];
                              fetchEmployee();
                            }));
                          },
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
