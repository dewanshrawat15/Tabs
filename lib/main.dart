import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'components/colors.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
    theme: ThemeData(
      primaryColor: ThemeColor
    ),
  )
);