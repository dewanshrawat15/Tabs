import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/vector.png"),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 72),
            child: Text(
              "Tabs",
              style: TextStyle(
                fontSize: 24,
                fontFamily: "Product Sans"
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}