import 'package:flutter/material.dart';
import 'package:paywage/views/forgot_password_page.dart';
import 'package:paywage/views/register_page.dart';
import 'package:paywage/CustomTheme/CustomColors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
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

          // User ID Text Box
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10, bottom: 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: const [BoxShadow(color: CustomColors.paleGreenColour)],
              ),
              child: const SizedBox(
                width: 300,
                height: 50,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: CustomColors.darkGreenColour,
                      icon: Icon(
                        Icons.person,
                        color: CustomColors.lightModeTextColor,
                      ),
                      labelText: 'User ID',
                      labelStyle: TextStyle(
                          color: CustomColors.lightModeTextColor
                      ),
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

          // Password Text filed.
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20, bottom: 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                //Secondary paleGreen colour
                boxShadow: const [BoxShadow(color: CustomColors.paleGreenColour)],
              ),
              child: const SizedBox(
                width: 300,
                height: 50,// set width to 400
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      //Primary darkGreen colour
                      fillColor: CustomColors.darkGreenColour,
                      icon: Icon(
                        Icons.key,
                        color: CustomColors.lightModeTextColor,
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: CustomColors.lightModeTextColor
                      ),
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

          // Adding text Forgot password


           Padding(padding: const EdgeInsets.only(top: 30),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgotPassword()));
              },
            child:  const Center(
              child: Text('Forgot password?', style: (TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: CustomColors.paleGreenColour)),
              ),
            ),
            )
          ),

          // Adding register button to this page.
           Padding(padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const RegisterPage(title: 'Register')));
              },
            child:  const Center(
              child: Text('Register', style: (TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: CustomColors.paleGreenColour)),
              ),
            ),
            )
          ),

          // Adding login button
          Padding(padding: const EdgeInsets.only(top: 30),
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
                  'Login',
                  style: TextStyle(fontSize: 20,color: CustomColors.lightModeTextColor),

                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
