import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();

}

class _LoginPage extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 150.0,
      width: 190.0,
      padding: const EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
      ),
      child: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
  
}