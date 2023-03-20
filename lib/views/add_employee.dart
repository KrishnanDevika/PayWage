import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paywage/common/myAppBar.dart';
import 'package:paywage/common/BottomNavigationBar.dart';
import 'package:paywage/models/salary_type.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key, required this.title});

  final String title;

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  List<String> wage_type = [];
  Future getSalaryType() async{
    var url = 'https://dkrishnan.scweb.ca/Paywage/fetchsalarytype.php';
    http.Response response = await http.get(Uri.parse(url));
    var data = response.body;
    final parsed = jsonDecode(data).cast<Map<String, dynamic>>();
    setState(() {
      final List<SalaryType> type = parsed.map<SalaryType>((json) => SalaryType.fromJson(json)).toList();
      for(var i= 0; i <type.length; i++){
        wage_type.add(type[i].type);
        print(type[i].type);
      }
    });

    print(data.toString());
  }

  @override
  void initState() {
  this.getSalaryType();
  }


  String drop_down_value = 'Daily';
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController wageType = TextEditingController();
  TextEditingController baseRate = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(widget.title),
      body: SingleChildScrollView(
        child : Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 15),
                child: Text('CREATE NEW EMPLOYEE', style: TextStyle(fontSize: 24, color: Color(0xff7C8362), fontWeight: FontWeight.bold),),
              ),
              new Container(
                height: 45,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 10, top: 10, right: 15, bottom: 10),
                      child: Text('First Name', style: TextStyle(color: Colors.white, fontSize: 18),),),

                    new Expanded(
                        child: new TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Color(0xff57654E),
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

              new Container(
                height: 45,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 10, top: 10, right: 15, bottom: 10),
                      child: Text('Last Name', style: TextStyle(color: Colors.white, fontSize: 18),),),

                    new Expanded(
                        child: new TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Color(0xff57654E),
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

              new Container(
                height: 45,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 10, top: 10, right: 20, bottom: 10),
                      child: Text('Start Date', style: TextStyle(color: Colors.white, fontSize: 18),),),

                    new Expanded(
                        child: new TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Color(0xff57654E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: startDate,
                        ))
                  ],
                ),
              ),

              new Container(
                height: 45,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(10),
                      child: Text('Contact No', style: TextStyle(color: Colors.white, fontSize: 18),),),

                    new Expanded(
                        child: new TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Color(0xff57654E),
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
              new Container(
                height: 45,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 10, top: 10, right: 55, bottom: 10),
                      child: Text('Street', style: TextStyle(color: Colors.white, fontSize: 18),),),

                    new Expanded(

                        child: new TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Color(0xff57654E),
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
              new Container(
                height: 45,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 10, top: 10, right: 70, bottom: 10),
                      child: Text('City', style: TextStyle(color: Colors.white, fontSize: 18),),),

                    new Expanded(
                        child: new TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Color(0xff57654E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: city,
                        ))
                  ],
                ),
              ),
              new Container(
                height: 45,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 10, top: 10, right: 60, bottom: 10),
                      child: Text('State', style: TextStyle(color: Colors.white, fontSize: 18),),),

                    new Expanded(
                        child: new TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Color(0xff57654E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: state,
                        ))
                  ],
                ),
              ),
              new Container(
                height: 45,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                      child: Text('Occupation', style: TextStyle(color: Colors.white, fontSize: 18),),),

                    new Expanded(
                        child: new TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Color(0xff57654E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: occupation,
                        ))
                  ],
                ),
              ),
              new Container(
                height: 45,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff7C8362),
                ),
                child: Row(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 10, top: 10, right: 15, bottom: 10),
                      child: Text('Wage type', style: TextStyle(color: Colors.white, fontSize: 18),),),

                    new Expanded(
                      child : DecoratedBox(
                        decoration: BoxDecoration(
                            color:Color(0xff57654E), //background color of dropdown button
                            border: Border.all(color: Colors.black), //border of dropdown button
                            borderRadius: BorderRadius.circular(10), //border radius of dropdown button

                        ),

                        child:Padding(
                          padding: EdgeInsets.only(left:20, right:30),
                          child: DropdownButton(
                            dropdownColor: Color(0xff57654E),

                            underline: Container(),
                            value: drop_down_value,
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
                                drop_down_value = newValue!;
                              });
                            },
                          ),
                    ),
                    ),
                    ),
                  ],
                ),
              ),
              new Container(
                height: 45,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff7C8362),
                ),
                child: Row(

                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 10, top: 10, right: 30, bottom: 10),
                      child: Text('Wage/hr', style: TextStyle(color: Colors.white, fontSize: 18),),),

                    new Expanded(
                        child: new TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Color(0xff57654E),
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


              new Padding(
                padding: new EdgeInsets.all(64.0),
                //onPressed will show login with the username typed on terminal
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff31473A), foregroundColor: Colors.white),
                  onPressed: () => print('created'),
                  child: new Text('Create'),
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
