import 'package:flutter/material.dart';
import 'package:paywage/3rd%20party%20Auth/google_sign_in_button.dart';
import 'package:paywage/CustomTheme/CustomColors.dart';
import 'package:paywage/views/payment_page.dart';
import 'package:provider/provider.dart';

import '../CustomTheme/theme_model.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key, required this.title});

  final String title;

  @override
  State<UserProfile> createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  double v = PaymentPage.getValue();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        NetworkImage(AuthenticatedUserInfo.userProfileImage!),
                  ),
                ),
              ),

//user Email
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [
                        BoxShadow(color: CustomColors.paleGreenColour)
                      ]),
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        const Text('Email'),
                        const SizedBox(width: 34),
                        Container(
                          width: 270,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: const [
                              BoxShadow(color: Color.fromRGBO(49, 71, 58, 0.5))
                            ],
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AuthenticatedUserInfo.userEmail!,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [
                        BoxShadow(color: CustomColors.paleGreenColour)
                      ]),
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        const Text('Name'),
                        const SizedBox(width: 40),
                        Container(
                          width: 260,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: const [
                              BoxShadow(color: Color.fromRGBO(49, 71, 58, 0.5))
                            ],
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AuthenticatedUserInfo.userName!,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: 350,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [
                        BoxShadow(color: CustomColors.paleGreenColour)
                      ]),
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 5),
                        const Text('Amount Due'),
                        const SizedBox(width: 5),
                        Container(
                          width: 260,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: const [
                              BoxShadow(color: Color.fromRGBO(49, 71, 58, 0.5))
                            ],
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "\u0024  ${v.toString()}",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ));
    });
  }
}
