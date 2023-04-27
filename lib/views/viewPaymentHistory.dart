import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paywage/common/myAppBar.dart';
import 'package:paywage/views/attendance_page.dart';
import 'package:paywage/views/payment_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewPaymentHistory extends StatefulWidget {
  const ViewPaymentHistory(
      {super.key, required this.title, required this.date});

  final String title;
  final String date;

  @override
  State<ViewPaymentHistory> createState() => _ViewPaymentHistoryState();
}

class _ViewPaymentHistoryState extends State<ViewPaymentHistory> {
  TextEditingController dateinput = TextEditingController();
  final List<TextEditingController> _payType= [];
  final List<TextEditingController> _pendingAmount = [];

  int _selectedIndex = 0;
  List<String> textValue = <String>[];


  Future fetchPayment() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/viewPayment.php';
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
              margin:
                  const EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 10),
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

                        if (dateinput.text.compareTo('2023-04-11') < 0) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ViewPaymentHistory(
                                  title: 'Pay Wage', date: '2023-04-11')));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewPaymentHistory(
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
                          firstDate: DateTime(2023),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                        );

                        if (date != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(date!);
                          dateinput.text = formattedDate;

                          if (date.isAfter(DateTime.now())) {
                            String formattedDate = DateFormat('yyyy-MM-dd')
                                .format(DateTime.now()
                                    .subtract(const Duration(days: 1)));
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewPaymentHistory(
                                    title: 'Pay Wage', date: formattedDate)));
                          } else if (formattedDate.compareTo('2023-04-11') <
                              0) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ViewPaymentHistory(
                                    title: 'Pay Wage', date: '2023-04-11')));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewPaymentHistory(
                                    title: 'Pay Wage', date: dateinput.text)));
                          }
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

                        if (((DateFormat('yyyy-MM-dd').format(pastDate))
                                    .compareTo(DateFormat('yyyy-MM-dd')
                                        .format(DateTime.now())) ==
                                0) ||
                            pastDate.isAfter(DateTime.now())) {
                          String formattedDate = DateFormat('yyyy-MM-dd')
                              .format(DateTime.now()
                                  .subtract(const Duration(days: 1)));
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewPaymentHistory(
                                  title: 'Pay Wage', date: formattedDate)));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ViewPaymentHistory(
                                  title: 'Pay Wage', date: dateinput.text)));
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
                FutureBuilder(
                  future: fetchPayment(),
                  builder: (context, snapshot) {
                    var data = snapshot.data;
                    if(data == false){
                      return const Center(child : Text('Payment is not made on that day',
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
                            _payType.add(TextEditingController());
                            _pendingAmount.add(TextEditingController());

                            _payType[index].text =
                            list[index]['pay_type'];
                            _pendingAmount[index].text =
                            list[index]['payment_amount'];


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
                                      /*  SizedBox(
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
                                        ),*/
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
                                        SizedBox(
                                          width: 100,
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
                                            controller: _payType[index],
                                            //editing controller of this TextField
                                          ),
                                        ),

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
                                          width: 150,
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
                                            controller: _pendingAmount[index],
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
          ]),


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
