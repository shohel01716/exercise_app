
import 'dart:async';

import 'package:exercise_app/Const/local_image.dart';
import 'package:exercise_app/Screen/home_screen.dart';
import 'package:flutter/material.dart';






class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(new Duration(seconds: 3),(){
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())) ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          LocalImages.logo,
          width: 160,
          height:160,

        ),
      ),
    );
  }
}