


import 'package:flutter/material.dart';
import 'package:paywage/CustomTheme/theme_model.dart';
import 'package:paywage/views/forgot_password_page.dart';
import 'package:paywage/views/login_page.dart';
import 'package:paywage/views/attendance_page.dart';
import 'package:paywage/views/payment_page.dart';
import 'package:paywage/views/register_page.dart';
import 'package:paywage/views/settings_page.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer(

        builder: (context, ThemeModel themeNotifier, child){

          return MaterialApp(
              title: 'Pay Wage',
              theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
              home: RegisterPage(title: "Paywage",)
          );
        },


      ),

    );
  }
}
