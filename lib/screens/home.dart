import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:tabs/components/drawer.dart';

class HomeScreen extends StatefulWidget{
  @override
  HomeScreenState createState() => HomeScreenState();
}

bool themeState = true;

class HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeState ? ThemeData(brightness: Brightness.light, primaryColor: Colors.deepOrange, accentColor: Colors.deepOrange) : ThemeData(brightness: Brightness.dark, primaryColor: Colors.deepOrange, accentColor: Colors.deepOrange),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Tabs",
            style: TextStyle(fontFamily: "Product Sans", fontSize: 24),
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
                onTap: (){
                  Share.share("Hey, I keep tabs on my purchases and transactions using Tabs. Join me by downloading tabs from https://dewanshrawat.tech/");
                },
                child: Icon(Icons.share),
              ),
            )
          ],
        ),
        drawer: SlideInDrawer(themeState: themeState,),
      ),
    );
  }
}