
import 'package:flutter/material.dart';
import 'package:paywage/CustomTheme/CustomColors.dart';
import 'package:paywage/common/myAppBar.dart';
import 'package:provider/provider.dart';

import '../CustomTheme/theme_model.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {

  String _theme = "Dark";

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ThemeModel themeNotifier, child){
      return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Settings",
                style: TextStyle(
                fontSize: 30,
                  fontWeight: FontWeight.bold
                ),),
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: const [BoxShadow(color: CustomColors.paleGreenColour)],
              ),
              child: InkWell(
                onTap: () {
                  // themeNotifier.isDark ? themeNotifier.isDark = false : themeNotifier.isDark = true;
                  // setState(() {
                  //   _theme = themeNotifier.isDark ? "Dark" : "Light"; // Update _theme variable
                  // });
                },
                child: Row(

                  children: [
                    const SizedBox(width: 15),

                    Text("Theme", style: TextStyle(
                      fontSize: 18,
                    ),),

                    const SizedBox(width: 30),

                    Container(
                      alignment: Alignment.centerLeft,
                        width: 290,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: const [BoxShadow(color: CustomColors.darkGreenColour)],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: InkWell(
                            onTap: (){
                              themeNotifier.isDark ? themeNotifier.isDark = false : themeNotifier.isDark = true;
                              setState(() {
                                _theme = themeNotifier.isDark ? "Light" : "Dark"; // Update _theme variable
                              });
                            },
                            child: Text(
                              _theme ,
                              textAlign: TextAlign.start,
                              style: (TextStyle(fontSize: 18)),
                            ),
                          ),
                        )
                    )
                  ],
                ),
              ),
            ),

            // IconButton(onPressed: (){
            //   themeNotifier.isDark ? themeNotifier.isDark = false : themeNotifier.isDark = true;
            // }, icon: Icon(
            //     themeNotifier.isDark ? Icons.wb_sunny : Icons.nightlight_round
            // ))
          ],
        )
      );
      }
    );
  }


}