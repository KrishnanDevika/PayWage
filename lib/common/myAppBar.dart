import 'package:flutter/material.dart';

PreferredSizeWidget myAppBar(String title) {
  return AppBar(
    leadingWidth: 80,
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    title: Text(title,
        style: TextStyle(
          color: Color(0xff63684E),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        )),
    leading: Icon(
      Icons.settings,
      size: 42,
      color: Color(0xff7C8362),
    ),
    actions: [
      Icon(Icons.account_circle, size: 42, color: Color(0xff7C8362)),
      Padding(padding: EdgeInsets.only(right: 16))
    ],
  );
}
