import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:paywage/CustomTheme/CustomColors.dart';
import 'package:paywage/common/myAppBar.dart';
import '../CustomTheme/theme_model.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {

  String _theme = "Dark";
  String _notificationTime = "10:00 AM"; // initial notification time, update as needed

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  TimeOfDay _selectedTime = TimeOfDay(hour: 18, minute: 0);

  get onSelectNotification => null;

  // @override
  // void initState() {
  //   super.initState();
  //   var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher'); // Initialize Android notification settings
  //   var initializationSettingsIOS = IOSInitializationSettings(); // Initialize iOS notification settings
  //   var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  //   flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification); // Initialize the notification plugin
  // }
  //
  // Future<void> scheduleNotification() async {
  //   var time = _selectedTime; // Set the desired time for the notification (6 PM in this case)
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //       'reminder_channel_id', 'Reminder Channel', 'Channel for reminders',
  //       importance: Importance.max, priority: Priority.high); // Set Android notification details
  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails(); // Set iOS notification details
  //   var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  //


  //   await flutterLocalNotificationsPlugin.showDailyAtTime( // Schedule a daily notification at the specified time
  //       0,
  //       'Reminder',
  //       'This is a reminder text',
  //       time as Time,
  //       platformChannelSpecifics);
  // }

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

                    Container(
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
                            Text(_notificationTime, style: TextStyle(
                              fontSize: 18,
                            ),),
                            const SizedBox(width: 15),
                            Container(
                                alignment: Alignment.centerLeft,
                                width: 240,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: const [BoxShadow(color: CustomColors.darkGreenColour)],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: InkWell(
                                    onTap: (){
                                      _showTimePickerDialog();
                                    },
                                    child: Text(
                                      'Notification Time' ,
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
