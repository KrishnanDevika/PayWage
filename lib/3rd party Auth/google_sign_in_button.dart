import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:paywage/views/attendance_page.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}





class GoogleSignInButton extends StatefulWidget {
  final Function(GoogleSignInAccount) onSignIn;

  const GoogleSignInButton({Key? key, required this.onSignIn});

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}
String? _userName;
String? _userProfileImage;
String? _userEmail;

class AuthenticatedUserInfo{
  static String? userName = _userName;
  static String? userProfileImage = _userProfileImage;
  static String? userEmail = _userEmail;
}


class _GoogleSignInButtonState extends State<GoogleSignInButton> {



  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
    clientId: '',
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
          onTap: () async {
            try {
              final account = await _googleSignIn.signIn();
              widget.onSignIn(account!);

              // Update user profile image and name
              setState(() {
                _userName = account.displayName;
                _userProfileImage = account.photoUrl;
                _userEmail = account.email;
              });

              Navigator.push(context, MaterialPageRoute(builder: (context)=> AttendancePage(title: "Paywage")));
              
              print("User name: $_userName");
              print("User name: $_userEmail");
              print("User name: $_userProfileImage");
            } catch (error) {
              print(error);
            }
          },
          child: Expanded(
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
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Expanded(
                      child:

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Google',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
