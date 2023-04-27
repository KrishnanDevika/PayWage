import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paywage/views/attendance_page.dart';
import 'package:intl/intl.dart';
import 'package:paywage/common/myAppBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:paywage/models/pay_type.dart';
import 'package:paywage/models/attendance.dart';
import 'package:paywage/views/viewPaymentHistory.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.title});

  final String title;

  static double value = 0;
  static void setValue(double newValue) {
    value += newValue;
  }

  static double getValue() {
    return value;
  }

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<int> employeeList = <int>[];
  int _selectedIndex = 1;
  TextEditingController dateinput = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final List<TextEditingController> _totalAmount = [];
  final List<TextEditingController> _paidAmount = [];
  List<String> pay_type = <String>[];
  List<String> selectedPayType = <String>[];
  List<int> daysWorked = <int>[];
  List<int> payAmount = <int>[];
  List<String> firstname = <String>[];
  List<String> lastName = <String>[];

  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    dateinput.text = formattedDate;
    fetchEmployee();
    fetchPayType();
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
      print(e);
    }
  }

  void fetchEmployee() async {
    String name = "Null";
    print("FetchEmployee :${searchController.text.toString()}");
    if (searchController.text.isEmpty) {
      name = "Null";
    } else {
      name = searchController.text.toString();
    }
    var url = 'https://dkrishnan.scweb.ca/Paywage/calculatePay.php';
    try {
      http.Response response =
          await http.post(Uri.parse(url), body: {'first_name': name});
      var data = response.body;
      final parsed = jsonDecode(data).cast<Map<String, dynamic>>();
      final List<Attendance> list =
          parsed.map<Attendance>((json) => Attendance.fromJson(json)).toList();

        for (var i = 0; i < list.length; i++) {
          employeeList.add(list[i].empId);
        }
        print("FetchEmployee : ${employeeList.length}");

    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future getData() async {

    String name = "Null";

    if (searchController.text.isEmpty) {
      name = "Null";
    } else {
      name = searchController.text.toString();
    }
    var url = 'https://dkrishnan.scweb.ca/Paywage/calculatePay.php';
    final res = await http.post(Uri.parse(url), body: {'first_name': name});
    return json.decode(res.body);
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

  Future updatePayment(String fName, String lName, String date, String payType,
      double amount) async {
    final response = await http.post(
        Uri.parse('https://dkrishnan.scweb.ca/Paywage/updatePayment.php'),
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
                margin: const EdgeInsets.only(
                    left: 0, top: 10, right: 0, bottom: 10),
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
                          DateTime pastDate =
                              date.subtract(const Duration(days: 1));
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pastDate!);
                          dateinput.text = formattedDate;
                        });

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewPaymentHistory(
                                title: 'Pay Wage', date: dateinput.text)));
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
                            firstDate: DateTime(2020),
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
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xff7C8362),
                      prefixIcon: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            getData();
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                ),
              ),
              FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  if(data == false){
                    return const Center(child : Text('Employee with that Name is not found',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                    );
                  }
              /*    else{
                    var dataLength = data.length;
                    if(dataLength == 0){
                      return const Center(
                        child: Text('No data found'),
                      );
                    }*/
                    else{
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
                            _totalAmount.add(TextEditingController());

                            if (list[index]['salary_type'] == 2) {
                              int end = int.parse(list[index]['end_time']
                                  .replaceAll(RegExp(r'[^0-9]'), ''));
                              int start = int.parse(list[index]['start_time']
                                  .replaceAll(RegExp(r'[^0-9]'), ''));
                              int diff = end - start;
                              print("Time Diff $diff");
                              int pay = list[index]['pay_rate'];
                              double amount = ((diff / 100) *
                                  pay *
                                  list[index]['WorkedDays']);
                              print("AMount ${amount.round()}");
                              _totalAmount[index].text =
                              '\u0024 ${amount.round()}';
                            }
                            DateTime now = DateTime.now();
                            String formattedDate =
                            DateFormat('yyyy-MM-dd').format(now);

                            print(formattedDate);
                            print(list[index]['start_date'].toString());

                            if (list[index]['salary_type'] == 2 &&
                                list[index]['payment_amount'] != null) {
                              int remainingBalance = (int.parse(list[index]
                              ['payment_amount']
                                  .replaceAll(RegExp(r'[^0-9/-]'), '')));
                              print(" Remaining ${remainingBalance / 100}");
                              int end = int.parse(list[index]['end_time']
                                  .replaceAll(RegExp(r'[^0-9]'), ''));
                              int start = int.parse(list[index]['start_time']
                                  .replaceAll(RegExp(r'[^0-9]'), ''));
                              int diff = end - start;
                              print("Time Diff ${diff}");
                              int pay = list[index]['pay_rate'];

                         /*     if (list[index]['start_date']
                                  .toString()
                                  .compareTo(formattedDate) ==
                                  0 ) {*/
                                double amount = ((diff / 100) *
                                    pay *
                                    (list[index]['WorkedDays'])) +
                                    (remainingBalance) / 100;
                                print("AMount ${amount.round()}");
                                _totalAmount[index].text =
                                '\u0024 ${amount.round()}';
                            /*  } else {
                                double amount = ((diff / 100) *
                                    pay *
                                    (list[index]['WorkedDays'] - 1)) +
                                    (remainingBalance) / 100;
                                print("AMount ${amount.round()}");
                                _totalAmount[index].text =
                                '\u0024 ${amount.round()}';
                              }*/
                            }

                            if (list[index]['salary_type'] == 1) {
                              {
                                _totalAmount[index].text =
                                '\u0024 ${(list[index]['WorkedDays'] * list[index]['pay_rate'])}';
                              }
                            }

                            if (list[index]['salary_type'] == 1 &&
                                list[index]['payment_amount'] != null) {
                              int remainingBalance = (int.parse(list[index]
                              ['payment_amount']
                                  .replaceAll(RegExp(r'[^0-9/-]'), '')));
                              print(" Remaining ${remainingBalance / 100}");

                           /*   if (list[index]['start_date']
                                  .toString()
                                  .compareTo(formattedDate) ==
                                  0) {*/
                                _totalAmount[index].text =
                                '\u0024 ${((list[index]['WorkedDays']) * list[index]['pay_rate']) + (remainingBalance) / 100}';
                             /* } else {
                                _totalAmount[index].text =
                                '\u0024 ${((list[index]['WorkedDays'] - 1) * list[index]['pay_rate']) + (remainingBalance) / 100}';
                              }*/
                            }

                            PaymentPage.setValue(double.parse(_totalAmount[index]
                                .text
                                .replaceAll(RegExp(r'[^0-9/./-]'), '')));
                            _paidAmount.add(TextEditingController());
                            _paidAmount[index].text = '0';
                            for (int i = 0; i < list.length; i++) {
                              firstname.add(list[i]['first_name']);
                              lastName.add(list[i]['last_name']);
                              selectedPayType.add("Regular");
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
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0,
                                              top: 0,
                                              right: 15,
                                              bottom: 0),
                                          child: Text(
                                            name,
                                            style: const TextStyle(
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
                                              fillColor:
                                              const Color(0xff7C8362),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 2.0,
                                                    color: Colors.white),
                                                borderRadius:
                                                BorderRadius.circular(12.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 2.0,
                                                    color: Colors.white),
                                                borderRadius:
                                                BorderRadius.circular(12.0),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 2.0,
                                                    color: Colors.white),
                                                borderRadius:
                                                BorderRadius.circular(15.0),
                                              ),
                                            ),

                                            style: const TextStyle(
                                                color: Colors.white),
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
                                    padding: const EdgeInsets.only(
                                        left: 0, top: 0, right: 0, bottom: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        /*  new Expanded(
                                          child:*/
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: const Color(0xff7C8362),
                                            //background color of dropdown button
                                            border:
                                            Border.all(color: Colors.white),
                                            //border of dropdown button
                                            borderRadius: BorderRadius.circular(
                                                10), //border radius of dropdown button
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15, right: 15),
                                            child: DropdownButton(
                                              dropdownColor:
                                              const Color(0xff7C8362),
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
                                              fillColor:
                                              const Color(0xff7C8362),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 2.0,
                                                    color: Colors.white),
                                                borderRadius:
                                                BorderRadius.circular(12.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 2.0,
                                                    color: Colors.white),
                                                borderRadius:
                                                BorderRadius.circular(12.0),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 2.0,
                                                    color: Colors.white),
                                                borderRadius:
                                                BorderRadius.circular(15.0),
                                              ),
                                            ),

                                            style: const TextStyle(
                                                color: Colors.white),
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
                          : const CircularProgressIndicator();
                    }
                //  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(64.0),
                //onPressed will show login with the username typed on terminal
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff31473A),
                      foregroundColor: Colors.white),
                  onPressed: () {

                    if (searchController.text.isEmpty) {
                      for (int index = 0;
                          index < employeeList.length;
                          index++) {
                        double pendingAmount = 0;
                        if (selectedPayType[index] == "Regular") {
                          print(double.parse(_totalAmount[index]
                              .text
                              .replaceAll(RegExp(r'[^0-9/./-]'), '')));
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
                              .replaceAll(RegExp(r'[^0-9/./-]'), '')));
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
                    } else {
                      print("Update Length ${employeeList.length}");

                      for (int index = 0;
                          index < employeeList.length;
                          index++) {
                        double pendingAmount = 0;
                        if (selectedPayType[index] == "Regular") {
                          print(double.parse(_totalAmount[index]
                              .text
                              .replaceAll(RegExp(r'[^0-9/./-]'), '')));
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
                              .replaceAll(RegExp(r'[^0-9/./-]'), '')));
                          pendingAmount = double.parse(_totalAmount[index]
                              .text
                              .replaceAll(RegExp(r'[^0-9/./-]'), '')) -
                              double.parse(_paidAmount[index]
                                  .text
                                  .replaceAll(RegExp(r'[^0-9/./-]'), ''));

                        }
                        print("Update ${pendingAmount}");
                        print("Update ${firstname[index]}");
                        updatePayment(
                            firstname[index],
                            lastName[index],
                            dateinput.text,
                            selectedPayType[index],
                            pendingAmount);
                      }

                    }

                    final snackBar = SnackBar(
                      content: const Text(
                        'Payment Updated',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: const Color(0xff31473A),
                      action: SnackBarAction(
                        label: 'dismiss',
                        onPressed: () {
                          setState(() {
                            searchController.text = "";
                            getData();
                          });
                       /*   Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) =>
                                      const PaymentPage(title: 'Pay Wage')))
                              .then((value) => setState(() {
                                    getData();
                                    employeeList = [];
                                    fetchEmployee();
                                  }));*/
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text('MAKE PAYMENT'),
                ),
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
      ),
    );
  }
}
