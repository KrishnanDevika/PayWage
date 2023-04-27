


import 'package:flutter/material.dart';
import 'package:paywage/CustomTheme/theme_model.dart';
import 'package:paywage/views/register_page.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer(

        builder: (context, ThemeModel themeNotifier, child){
           ThemeData light = ThemeData(primarySwatch: Colors.lightGreen,
           brightness: Brightness.light);
           ThemeData dark = ThemeData(primarySwatch: Colors.lightGreen,
             brightness: Brightness.dark,
            );

          return MaterialApp(
              title: 'Pay Wage',
              theme: themeNotifier.isDark ? dark : light,
              home: const RegisterPage(title: "PayWage")
          );
        },


      ),

    );
  }
}
