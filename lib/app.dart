


import 'package:flutter/material.dart';
import 'package:paywage/views/login_page.dart';
import 'package:paywage/views/attendance_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Wage',
      theme: ThemeData(

       // primarySwatch: Colors.transparent,
      ),
      home: const AttendancePage(title: 'Pay Wage'),
    );
  }
}
