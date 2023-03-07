
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});

  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
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
              child: Text('Pay Wage', style: (TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Color.fromRGBO(49, 71, 58, 1))),),
            ),
          ),

          //Text box for forgot password information.
          Padding(padding: const EdgeInsets.only(bottom: 30),
            child:  Center(
              child: Container(
                width: 300,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(color: Color.fromRGBO(124, 131, 98, .5))],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
                  child: Column(
                    children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 18),
                        child: Text('New to PAYWAGE?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Text("Please register here.", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Register with google
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10, bottom: 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: const [BoxShadow(color: Color.fromRGBO(124, 131, 98, 1))],
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
                      fillColor: Color.fromRGBO(49, 71, 58, 0.5),
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      labelText: 'Google',
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

          // Register with Facebook
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20, bottom: 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: const [BoxShadow(color: Color.fromRGBO(124, 131, 98, 1))],
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
                      fillColor: Color.fromRGBO(49, 71, 58, 0.5),
                      icon: Icon(
                        Icons.key,
                        color: Colors.white,
                      ),
                      labelText: 'Facebook',
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

          // Register with APPLE
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20, bottom: 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: const [BoxShadow(color: Color.fromRGBO(124, 131, 98, 1))],
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
                      fillColor: Color.fromRGBO(49, 71, 58, 0.5),
                      icon: Icon(
                        Icons.key,
                        color: Colors.white,
                      ),
                      labelText: 'Apple',
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
        ],
      ),
    );
  }


}