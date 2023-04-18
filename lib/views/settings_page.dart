import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:paywage/CustomTheme/CustomColors.dart';
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


  TimeOfDay _selectedTime = const TimeOfDay(hour: 18, minute: 0);

  get onSelectNotification => null;

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
                    const Padding(
                      padding: EdgeInsets.all(10.0),
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
                              const Text("Theme", style: TextStyle(
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
                                    padding: const EdgeInsets.all(15.0),
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
                                        style: (const TextStyle(fontSize: 18)),
                                      ),
                                    ),
                                  )
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

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
                            Text(_notificationTime, style: const TextStyle(
                              fontSize: 18,
                            ),),
                            const SizedBox(width: 13),
                            Container(
                                alignment: Alignment.centerLeft,
                                width: 245,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: const [BoxShadow(color: CustomColors.darkGreenColour)],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: InkWell(
                                    onTap: (){
                                      _showTimePickerDialog();
                                    },
                                    child: const Text(
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

                  ],
                ),
              )
          );
        }
    );
  }
}
