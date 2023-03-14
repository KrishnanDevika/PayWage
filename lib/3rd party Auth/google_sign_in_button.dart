import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInButton extends StatefulWidget {
  final Function(GoogleSignInAccount) onSignIn;

  const GoogleSignInButton({super.key, required this.onSignIn});

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

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
            try {
              final account = await _googleSignIn.signIn();
              widget.onSignIn(account!);
            } catch (error) {
              print(error);
            }
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
