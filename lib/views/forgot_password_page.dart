import 'package:flutter/material.dart';

import '../CustomTheme/CustomColors.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Adding image.
          Padding(padding: const EdgeInsets.only(bottom: 30),
            child: Center(
              child: SizedBox(
                width: 200,
                height: 150,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
          ),

          // Application Name
          const Padding(padding: EdgeInsets.only(bottom: 60),
            child:  Center(
              child: Text('Pay Wage', style: (TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: CustomColors.darkGreenColour)),),
            ),
          ),

          // Text box showing instruction
          Padding(padding: const EdgeInsets.only(bottom: 10),
            child:  Center(
              child: Container(
                width: 300,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(color: CustomColors.paleGreenColour)],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                  child: Column(
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Text('New to PAYWAGE?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Text("Enter you email and we’ll send you a link to reset password.", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Email Text Box
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10, bottom: 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [BoxShadow(color: CustomColors.paleGreenColour.withOpacity(1))],
              ),
              child: SizedBox(
                width: 300,
                height: 50,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: CustomColors.darkGreenColour.withOpacity(0.5),
                      icon: Icon(
                        Icons.email,
                        color: CustomColors.lightModeTextColor,
                      ),
                      labelText: 'Email',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(color: Colors.grey, width: 0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Adding submit button
          Padding(padding: const EdgeInsets.only(top: 50),
            child: ElevatedButton(
              onPressed: () {
                // submit logic
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                   CustomColors.darkGreenColour,
                ),
                side: MaterialStateProperty.all<BorderSide>(
                  const BorderSide(
                    color: CustomColors.paleGreenColour, // change the color here
                    width: 4.0, // change the width here
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(13.0),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
