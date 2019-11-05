import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  @override
  HomeScreenState createState() => HomeScreenState();
}

bool themeState = false;

class HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeState ? ThemeData(brightness: Brightness.light,primaryColor: Colors.deepOrange) : ThemeData(brightness: Brightness.dark, primaryColor: Colors.deepOrange),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Tabs",
            style: TextStyle(fontFamily: "Product Sans"),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, right: 15),
              child: InkWell(
                onTap: (){
                  setState(() {
                    themeState = !themeState;
                  });
                },
                child: Icon(Icons.lightbulb_outline),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 20),
              child: InkWell(
                child: Icon(Icons.share),
              ),
            )
          ],
        ),
      ),
    );
  }
}