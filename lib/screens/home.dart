import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/colors.dart';
import 'splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool registered = false;

class HomeScreen extends StatefulWidget{
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ThemeColor
    ));
    return SplashScreen();
  }
}