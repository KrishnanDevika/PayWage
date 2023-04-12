import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

class _GoogleSignInButtonState extends State<GoogleSignInButton> {

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
    clientId: '',
  );

  String? _userName;
  String? _userProfileImage;

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
              });

              print("User name: $_userName");
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
                        if (_userName != null && _userProfileImage != null) SizedBox(height: 8),
                        if (_userName != null && _userProfileImage != null)
                          Row(
                            children: [
                              CircleAvatar(

                                backgroundImage: NetworkImage(_userProfileImage!),
                                radius: 12,
                              ),
                              SizedBox(width: 8),
                              Text(
                                _userName!,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
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
