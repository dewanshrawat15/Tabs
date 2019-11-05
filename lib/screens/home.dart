import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget{
  @override
  HomeScreenState createState() => HomeScreenState();
}

bool themeState = true;

void setNull() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('firstAttempt', false);
}

class HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeState ? ThemeData(brightness: Brightness.light, primaryColor: Colors.deepOrange) : ThemeData(brightness: Brightness.dark, primaryColor: Colors.deepOrange),
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
        body: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
              default:
                if(!snapshot.hasError){
                  if(snapshot.data.getBool("firstAttempt") != null){
                    setNull();
                  }
                  return snapshot.data.getBool("firstAttempt") != null ? Center(child: Text("Loaded"),) : Center(child: Text("Not loaded"),);
                }
            }
          },
        ),
      ),
    );
  }
}