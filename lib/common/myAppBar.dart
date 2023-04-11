
import 'package:flutter/material.dart';
import 'package:paywage/CustomTheme/CustomColors.dart';
import 'package:paywage/views/settings_page.dart';

PreferredSizeWidget myAppBar(String title) {
  return AppBar(
    leadingWidth: 80,
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    title: Text(title,
        style: TextStyle(
          color: CustomColors.paleGreenColour,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        )),
    leading: IconButton(
      icon: Icon(Icons.settings, size:42,),
      color: CustomColors.paleGreenColour,
      onPressed: (){
        //Navigator.push( context, MaterialPageRoute(builder: (context) => SettingsPage(title: "Paywage")));
      },
    ),
    actions: [
      Icon(Icons.account_circle, size: 42, color: CustomColors.paleGreenColour),
      Padding(padding: EdgeInsets.only(right: 16))
    ],
  );
}
