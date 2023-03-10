import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paywage/common/myAppBar.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({super.key, required this.title});

  final String title;

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
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
                        child: new TextField(
                          decoration: InputDecoration(
                            fillColor: Color(0xff57654E),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: wageType,
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
                    Padding(padding: EdgeInsets.only(left: 10, top: 10, right: 30, bottom: 10),
                      child: Text('Wage/hr', style: TextStyle(color: Colors.white, fontSize: 18),),),

                    new Expanded(
                        child: new TextField(
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

    );
  }
}
