import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class FacebookSignInButton extends StatefulWidget {

  const FacebookSignInButton({super.key});

  @override
  _FacebookSignInButtonState createState() => _FacebookSignInButtonState();
}

class _FacebookSignInButtonState extends State<FacebookSignInButton> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [BoxShadow(color: Color.fromRGBO(124, 131, 98, 1))],
        ),
        child: InkWell(
          onTap: ()async {
            // try {
            //   final account = await _facebookSignIn.signIn();
            //   widget.onSignIn(account!);
            // } catch (error) {
            //   print(error);
            // }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const SizedBox(width: 15),

              Image.asset(
                'assets/images/google.png',
                height: 24,
                width: 24,
              ),

              const SizedBox(width: 18),

              Container(
                  width: 240,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: const [BoxShadow(color: Color.fromRGBO(49, 71, 58, 0.5))],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Google',
                      textAlign: TextAlign.start,
                      style: (TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
