import 'package:flutter/material.dart';
import '../components/colors.dart';

class GetttingStarted extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/vector.png"),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 64, horizontal: 72),
            child: Text(
              "Tabs, a new way to keep track of your money",
              style: TextStyle(
                fontSize: 24,
                fontFamily: "Product Sans"
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 250,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: RaisedButton(
                onPressed: (){},
                color: ThemeColor,
                padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 60.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Create Account",
                        style: TextStyle(
                          fontFamily: "Google Sans",
                          fontSize: 18,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}