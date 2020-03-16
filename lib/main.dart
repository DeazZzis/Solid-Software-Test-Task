import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RandomColors(),
    );
  }
}

class RandomColorsState extends State<RandomColors> {
  Random random = new Random();
  int _red = 255;
  int _blue = 255;
  int _green = 255;
  int _red_negative = 0;
  int _blue_negative = 0;
  int _green_negative = 0;

  void _onTap() {
    setState(() {
      _red = random.nextInt(255);
      _blue = random.nextInt(255);
      _green = random.nextInt(255);
      _red_negative = 255 - _red;
      _blue_negative = 255 - _blue;
      _green_negative = 255 - _green;
    });
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

class RandomColors extends StatefulWidget {
  @override
  RandomColorsState createState() => RandomColorsState();
}
