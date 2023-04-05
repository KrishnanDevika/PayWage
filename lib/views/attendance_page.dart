import 'package:flutter/material.dart';
import 'package:paywage/views/add_employee.dart';
import 'package:paywage/views/payment_page.dart';
import 'package:intl/intl.dart';
import 'package:paywage/common/myAppBar.dart';
import 'package:paywage/common/BottomNavigationBar.dart';
import 'package:paywage/models/employee.dart';
import 'package:paywage/models/job_site.dart';
import 'package:paywage/models/occupation.dart';
import 'package:paywage/views/update_employee.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key, required this.title});

  final String title;

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<String> employeeList = <String>[];
  List<String> sitesList = <String>[];
  List<String> occupationList = <String>[];
  List<bool> _isChecked = [];
  List<String> selectedSiteValue = <String>[];
  List<String> selectedOccupationValue = <String>[];
  TextEditingController dateinput = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<TextEditingController> _timeinput = [];
  List<TextEditingController> _timeOut = [];
  List<String> textValue = <String>[];
  int _selectedIndex = 0;

  List<String> firstname = <String>[];
  List<String> lastName = <String>[];
  List<String> dateList = <String>[];
  List<String> contactList = <String>[];

  @override
  void initState() {
    dateinput.text = "";
    this.fetchEmployee();
    this.fetchJobSites();
    this.fetchOccupation();
    super.initState();
  }

  Future deleteEmployee(BuildContext context, String id) async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/deleteEmployee.php';
    final response = await http.post(Uri.parse(url), body: {
      'id': id,
    });
    print((response.body));
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (context) => AttendancePage(title: 'Pay Wage')))
        .then((value) => setState(() {
              getData();
              employeeList = [];
              fetchEmployee();
            }));
  }

  void showAlert(BuildContext context, int id) {
    print(id);
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        deleteEmployee(context, id.toString());
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Employee"),
      content: Text("Do you want to delete this employee?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future fetchAttendance(String date) async{
    var url = 'https://dkrishnan.scweb.ca/Paywage/fetchAttendance.php';
    final res = await http.post(Uri.parse(url), body: {
      'date': date,
    });
    print(date);
    print(res.body);
    return json.decode(res.body);
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
          employeeList.add(employee[i].firstName + " " + employee[i].lastName);
          firstname.add(employee[i].firstName);
          lastName.add(employee[i].lastName);
          dateList.add(employee[i].startDate);
          contactList.add(employee[i].contactNo);
        }
        _isChecked = List<bool>.filled(employeeList.length, false);
        textValue = List<String>.filled(employeeList.length, 'Absent');
      });
    } catch (e) {
      print(e);
    }
  }

  void fetchJobSites() async {
    var url = 'https://dkrishnan.scweb.ca/Paywage/fetchSites.php';
    try {
      http.Response response = await http.get(Uri.parse(url));
      var data = response.body;
      final parsed = jsonDecode(data).cast<Map<String, dynamic>>();

      final List<JobSite> sites =
          parsed.map<JobSite>((json) => JobSite.fromJson(json)).toList();
      setState(() {
        for (var i = 0; i < sites.length; i++) {
          sitesList.add(sites[i].siteName);
        }
      });
    } catch (e) {
      print(e);
    }
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
    } catch (e) {
      print(e);
    }
  }

  Future createAttendance(
      String fName,
      String lName,
      bool present,
      String time_in,
      String time_out,
      String site_name,
      String occupation) async {
    String attendance = 'false';
    if (present == true) {
      attendance = 'true';
    } else {
      attendance = 'false';
    }

    final response = await http.post(
        Uri.parse('https://dkrishnan.scweb.ca/Paywage/insertAttendance.php'),
        body: {
          "first_name": fName,
          "last_name": lName,
          "date": dateinput.text,
          "site_name": site_name,
          "occupation_type": occupation,
          "start_time": time_in,
          "end_time": time_out,
          "present": attendance
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
                        fetchAttendance(dateinput.text);
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
                            _timeOut.add(new TextEditingController());
                            _timeinput.add(new TextEditingController());
                            for (int i = 0; i < list.length; i++) {
                              selectedSiteValue.add("Karur");
                              selectedOccupationValue.add("Roofing");
                            }
                            return InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateEmployeePage(
                                                title: 'Pay Wage',
                                                list: list,
                                                occupation: occupationList,
                                                index: index)))
                                    .then((value) => setState(() {
                                          getData();
                                        }));
                              },
                              onLongPress: () {
                                setState(() {
                                  showAlert(context, list[index]['id']);
                                });
                              },
                              child: Card(
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
                                              if (_isChecked[index] == false) {
                                                setState(() {
                                                  _isChecked[index] = true;
                                                  textValue[index] = 'Present';
                                                });
                                              } else {
                                                setState(() {
                                                  _isChecked[index] = false;
                                                  textValue[index] = 'Absent';
                                                });
                                              }
                                            },
                                          ),
                                          Text(textValue[index],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
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
                                              //set it true, so that user will not able to edit text
                                              onTap: () async {
                                                final TimeOfDay? pickedTime =
                                                    await showTimePicker(
                                                  initialTime: TimeOfDay.now(),
                                                  context: context,
                                                );

                                                if (pickedTime != null) {
                                                  // print(pickedTime.format(context)); //output 10:51 PM
                                                  DateTime parsedTime =
                                                      DateFormat.jm().parse(
                                                          pickedTime
                                                              .format(context)
                                                              .toString());
                                                  //converting to DateTime so that we can further format on different pattern.
                                                  //print(parsedTime); //output 1970-01-01 22:53:00.000
                                                  String formattedTime =
                                                      DateFormat('HH:mm')
                                                          .format(parsedTime);
                                                  //print(formattedTime); //output 14:59:00
                                                  //DateFormat() is from intl package, you can format the time on any pattern you need.

                                                  _timeinput[index].text =
                                                      formattedTime; //set the value of text field.
                                                }
                                                ;
                                              },
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
                                              //set it true, so that user will not able to edit text
                                              onTap: () async {
                                                final TimeOfDay? pickedTime =
                                                    await showTimePicker(
                                                  initialTime: TimeOfDay.now(),
                                                  context: context,
                                                );

                                                if (pickedTime != null) {
                                                  //    print(pickedTime.format(context)); //output 10:51 PM
                                                  DateTime parsedTime =
                                                      DateFormat.jm().parse(
                                                          pickedTime
                                                              .format(context)
                                                              .toString());
                                                  //converting to DateTime so that we can further format on different pattern.
                                                  //print(parsedTime); //output 1970-01-01 22:53:00.000
                                                  String formattedTime =
                                                      DateFormat('HH:mm')
                                                          .format(parsedTime);
                                                  _timeOut[index].text =
                                                      formattedTime; //set the value of text field.
                                                }
                                                ;
                                              },
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
                                          new Expanded(
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: Color(0xff7C8362),
                                                border: Border.all(
                                                    color: Colors.black38),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 30),
                                                child: DropdownButton(
                                                  dropdownColor:
                                                      Color(0xff7C8362),
                                                  underline: Container(),
                                                  value:
                                                      selectedSiteValue[index],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  icon: const Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.white,
                                                  ),
                                                  items: sitesList
                                                      .map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(
                                                        items,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                    );
                                                  }).toList(),
                                                  // After selecting the desired option,it will
                                                  // change button value to selected value
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      selectedSiteValue[index] =
                                                          newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          new Expanded(
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: Color(0xff7C8362),
                                                border: Border.all(
                                                    color: Colors.black38),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: DropdownButton(
                                                  dropdownColor:
                                                      Color(0xff7C8362),
                                                  underline: Container(),
                                                  value:
                                                      selectedOccupationValue[
                                                          index],

                                                  icon: const Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.white,
                                                  ),
                                                  items: occupationList
                                                      .map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(
                                                        items,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                    );
                                                  }).toList(),
                                                  // After selecting the desired option,it will
                                                  // change button value to selected value
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      selectedOccupationValue[
                                                          index] = newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                      : CircularProgressIndicator();
                },
              ),

              /*   Container(
                margin: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: employeeList.length,
                  itemBuilder: (context, index) {
                    _timeOut.add(new TextEditingController());
                    _timeinput.add(new TextEditingController());
                    for (int i = 0; i < employeeList.length; i++) {
                      selectedSiteValue.add("Karur");
                      selectedOccupationValue.add("Roofing");
                    }
                    return InkWell(
                      onTap: (){

                        Navigator.of(context)
                            .push(MaterialPageRoute(
                            builder: (context) => UpdateEmployeePage(
                                title: 'Pay Wage', employee_flist: firstname,
                                employee_llist : lastName , dateList: dateList, contactList : contactList, occupation_list:occupationList, index: index)))
                            .then((value) => setState(() {
                          employeeList = [];
                          fetchEmployee();
                        }));

                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        color: Color(0xff31473A),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                employeeList[index],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10, top: 0, right: 10, bottom: 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Switch(
                                    value: _isChecked[index],
                                    activeColor: Color(0xff7C8362),
                                    activeTrackColor: Colors.white,
                                    inactiveThumbColor: Color(0xff7C8362),
                                    inactiveTrackColor: Color(0xff7C8362).withOpacity(0.5),
                                    onChanged: (val) {
                                      if (_isChecked[index] == false) {
                                        setState(() {
                                          _isChecked[index] = true;
                                          textValue[index] = 'Present';
                                        });
                                      } else {
                                        setState(() {
                                          _isChecked[index] = false;
                                          textValue[index] = 'Absent';
                                        });
                                      }
                                    },
                                  ),
                                  Text(textValue[index],
                                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 30, top: 0, right: 30, bottom: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                          BorderRadius.circular(20.0),
                                        ),
                                      ),

                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                      controller: _timeinput[index],
                                      //editing controller of this TextField
                                      readOnly: true,
                                      //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        final TimeOfDay? pickedTime =
                                        await showTimePicker(
                                          initialTime: TimeOfDay.now(),
                                          context: context,
                                        );

                                        if (pickedTime != null) {
                                          // print(pickedTime.format(context)); //output 10:51 PM
                                          DateTime parsedTime = DateFormat.jm()
                                              .parse(pickedTime
                                              .format(context)
                                              .toString());
                                          //converting to DateTime so that we can further format on different pattern.
                                          //print(parsedTime); //output 1970-01-01 22:53:00.000
                                          String formattedTime =
                                          DateFormat('HH:mm')
                                              .format(parsedTime);
                                          //print(formattedTime); //output 14:59:00
                                          //DateFormat() is from intl package, you can format the time on any pattern you need.

                                          _timeinput[index].text =
                                              formattedTime; //set the value of text field.
                                        }
                                        ;
                                      },
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
                                          BorderRadius.circular(20.0),
                                        ),
                                      ),

                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                      controller: _timeOut[index],
                                      //editing controller of this TextField
                                      readOnly: true,
                                      //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        final TimeOfDay? pickedTime =
                                        await showTimePicker(
                                          initialTime: TimeOfDay.now(),
                                          context: context,
                                        );

                                        if (pickedTime != null) {
                                          //    print(pickedTime.format(context)); //output 10:51 PM
                                          DateTime parsedTime = DateFormat.jm()
                                              .parse(pickedTime
                                              .format(context)
                                              .toString());
                                          //converting to DateTime so that we can further format on different pattern.
                                          //print(parsedTime); //output 1970-01-01 22:53:00.000
                                          String formattedTime =
                                          DateFormat('HH:mm')
                                              .format(parsedTime);
                                          _timeOut[index].text =
                                              formattedTime; //set the value of text field.
                                        }
                                        ;
                                      },
                                    ),
                                  ),
                                  // TextField()
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10, top: 10, right: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  new Expanded(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Color(0xff7C8362),
                                        border: Border.all(color: Colors.black38),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: DropdownButton(
                                          dropdownColor: Color(0xff7C8362),
                                          underline: Container(),
                                          value: selectedSiteValue[index],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.white,
                                          ),
                                          items: sitesList.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(
                                                items,
                                              ),
                                              alignment: Alignment.center,
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedSiteValue[index] =
                                              newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  new Expanded(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Color(0xff7C8362),
                                        border: Border.all(color: Colors.black38),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: DropdownButton(
                                          dropdownColor: Color(0xff7C8362),
                                          underline: Container(),
                                          value: selectedOccupationValue[index],

                                          icon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.white,
                                          ),
                                          items:
                                          occupationList.map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(
                                                items,
                                              ),
                                              alignment: Alignment.center,
                                            );
                                          }).toList(),
                                          // After selecting the desired option,it will
                                          // change button value to selected value
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedOccupationValue[index] =
                                              newValue!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );

                  },
                ),
              ),*/
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
                        createAttendance(
                            firstname[index],
                            lastName[index],
                            _isChecked[index],
                            _timeinput[index].text,
                            _timeOut[index].text,
                            selectedSiteValue[index],
                            selectedOccupationValue[index]);
                      }
                      final snackBar = SnackBar(
                        content: Text(
                          'Attendance marked',
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
                    child: new Text('MARK ATTENDANCE'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff7C8362),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => AddEmployeePage(title: 'Pay Wage')))
              .then((value) => setState(() {
                    getData();
                    employeeList = [];
                    fetchEmployee();
                  }));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
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
