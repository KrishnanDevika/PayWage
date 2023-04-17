import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:paywage/main.dart';
import 'package:provider/provider.dart';
import 'package:paywage/CustomTheme/CustomColors.dart';
import 'package:paywage/common/myAppBar.dart';
import '../CustomTheme/theme_model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPage();
}


class _SettingsPage extends State<SettingsPage> {

  String _theme = "Dark";
  String _notificationTime = "10:00 AM"; // initial notification time, update as needed

  TimeOfDay _selectedTime = TimeOfDay(hour: 18, minute: 0);

  get onSelectNotification => null;

  @override
  void initState(){
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if(notification != null && android != null){
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            )
          )
        );
      }
    });
    
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if(notification != null && android != null){
        showDialog(
            context: context,
            builder: (_){
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body!)
                    ],
                  ),
                ),
              );
            });
      }
    });
  }


  Future<void> _showTimePickerDialog() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        _notificationTime = pickedTime.format(context);
      });
    }
    // flutterLocalNotificationsPlugin.show(
    //   0,
    //   "Testing $_notificationTime",
    //   "This is your custom time selected",
    //   NotificationDetails(
    //     android: AndroidNotificationDetails(
    //       channel.id,
    //       channel.name,
    //       channel.description,
    //       importance: Importance.high,
    //       color: Colors.blue,
    //       playSound: true,
    //     )
    //   )
    // );
  }



  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ThemeModel themeNotifier, child){
          return Scaffold(
              appBar: AppBar(),
              body: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Settings",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: const [BoxShadow(color: CustomColors.paleGreenColour)],
                        ),
                        child: InkWell(
                          onTap: () {
                            // themeNotifier.isDark ? themeNotifier.isDark = false : themeNotifier.isDark = true;
                            // setState(() {
                            //   _theme = themeNotifier.isDark ? "Dark" : "Light"; // Update _theme variable
                            // });
                          },
                          child: Row(
                            children: [
                              const SizedBox(width: 15),
                              Text("Theme", style: TextStyle(
                                fontSize: 18,
                              ),),
                              const SizedBox(width: 30),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  width: 249,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: const [BoxShadow(color: CustomColors.darkGreenColour)],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: InkWell(
                                      onTap: (){
                                        themeNotifier.isDark ? themeNotifier.isDark = false : themeNotifier.isDark = true;
                                        setState(() {
                                          _theme = themeNotifier.isDark ? "Light" : "Dark"; // Update _theme variable
                                        });
                                      },
                                      child: Text(
                                        _theme ,
                                        textAlign: TextAlign.start,
                                        style: (TextStyle(fontSize: 18)),
                                      ),
                                    ),
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    //
                    // Container(
                    //   width: 350,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(15.0),
                    //     boxShadow: const [BoxShadow(color: CustomColors.paleGreenColour)],
                    //   ),
                    //   child: InkWell(
                    //     onTap: () {
                    //       // themeNotifier.isDark ? themeNotifier.isDark = false : themeNotifier.isDark = true;
                    //       // setState(() {
                    //       //   _theme = themeNotifier.isDark ? "Dark" : "Light"; // Update _theme variable
                    //       // });
                    //     },
                    //     child: Row(
                    //       children: [
                    //         const SizedBox(width: 15),
                    //         Text(_notificationTime, style: TextStyle(
                    //           fontSize: 18,
                    //         ),),
                    //         const SizedBox(width: 15),
                    //         Container(
                    //             alignment: Alignment.centerLeft,
                    //             width: 240,
                    //             height: 50,
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(15.0),
                    //               boxShadow: const [BoxShadow(color: CustomColors.darkGreenColour)],
                    //             ),
                    //             child: Padding(
                    //               padding: EdgeInsets.all(15.0),
                    //               child: InkWell(
                    //                 onTap: (){
                    //                   _showTimePickerDialog();
                    //                 },
                    //                 child: Text(
                    //                   'Notification Time' ,
                    //                   textAlign: TextAlign.start,
                    //                   style: (TextStyle(fontSize: 18)),
                    //                 ),
                    //               ),
                    //             )
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    // Container(
                    //   height: 50,
                    //   width: 350,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(15.0),
                    //     boxShadow: const [BoxShadow(color: CustomColors.paleGreenColour)],
                    //   ),
                    //   child: InkWell(
                    //     onTap: () {
                    //       // Add your code here to handle the custom time notification reminder
                    //     },
                    //     child: InkWell(
                    //       onTap: _showTimePickerDialog,
                    //       child: Row(
                    //         children: [
                    //           const SizedBox(width: 15),
                    //           Text("Notification Time", style: TextStyle(
                    //             fontSize: 18,
                    //           ),),
                    //           const SizedBox(width: 10),
                    //           Text(
                    //             _notificationTime,
                    //             style: TextStyle(fontSize: 18),
                    //           ),
                    //           const SizedBox(width: 10),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              )
          );
        }
    );
  }
}
