import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodorobeproductive/tasks_priortized_page.dart';
import 'package:pomodorobeproductive/user_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }

  late String? user;
  late SharedPreferences prefs;

  void initialiseSP() async {
    prefs = await SharedPreferences.getInstance();
    user = prefs.getString('user');
  }

  void navigationPage() {
    user == null
        ? Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UserForm()))
        : Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => PomodoroPage()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
    initialiseSP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff212238),
      body: Stack(
        children: [
          Center(
            child: Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Image.asset(
                  'asset/images/splash_screen.png',
                  fit: BoxFit.cover,
                )),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.blue.withOpacity(0.2),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.3,
            left: MediaQuery.of(context).size.width / 2.65,
            child: Text(
              "Pomodoro.",
              style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
