import 'dart:math';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RandomColors(),
    ));

class RandomColors extends StatefulWidget {
  @override
  RandomColorsState createState() => RandomColorsState();
}

class RandomColorsState extends State<RandomColors> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Random random = new Random();
  int _red = 255;
  int _blue = 255;
  int _green = 255;
  int _red_negative = 0;
  int _blue_negative = 0;
  int _green_negative = 0;

  Future<dynamic> onDidReceiveLocalNotification(
      int i, String a, String c, String d) async {}

  _sendNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    String textInNotification =
        'Background RGB color ( $_red; $_green; $_blue)\n'
        'Text RGB color ($_red_negative; $_green_negative; $_blue_negative)';
    await flutterLocalNotificationsPlugin.show(0, 'Your color:',
        textInNotification, platformChannelSpecifics,
        payload: 'item x');
  }

  initNoti() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  }

  @override
  void initState() {
    initNoti();
    super.initState();
  }

  void _onTap() {
    setState(() {
      _red = random.nextInt(255);
      _blue = random.nextInt(255);
      _green = random.nextInt(255);
      _red_negative = 255 - _red;
      _blue_negative = 255 - _blue;
      _green_negative = 255 - _green;
    });
    _sendNotification();
  }

  Color _changeTextColor() =>
      Color.fromARGB(255, _red_negative, _blue_negative, _green_negative);

  Color _changeBackgroundColor() => Color.fromARGB(255, _red, _green, _blue);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Scaffold(
        body: Center(
          child: Text(
            'Hey there',
            style: TextStyle(
              fontSize: 30.0,
              color: _changeTextColor(),
            ),
          ),
        ),
        backgroundColor: _changeBackgroundColor(),
      ),
    );
  }
}
