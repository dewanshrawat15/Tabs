import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'splash.dart';
import 'setup.dart';

import '../components/profile.dart';
import '../components/colors.dart';

class HomeScreen extends StatefulWidget{
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{

  connectDatabase() async{
    Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'accounts.db'),
      onCreate: (db, version){
        return db.execute(
          "CREATE TABLE accountDetails(name TEXT, username TEXT, email TEXT, photoURL TEXT)",
        );
      },
      version: 1
    );
    return database;
  }

  Future<List<Account>> getProfile() async => await Future.delayed(Duration(milliseconds: 1400), () async {
    final Database db = await connectDatabase();
    final List<Map<String, dynamic>> maps = await db.query('accountDetails');
    return List.generate(maps.length, (i){
      return Account(
        username: maps[i]['username']
      );
    });
  });

  @override
  Widget build(BuildContext context){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ThemeColor
    ));
    return Scaffold(
      body: FutureBuilder(
        future: getProfile(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data.length == 0){
              return Center(
                child: GetttingStarted(),
              );
            }
            else{
              return Center(
                child: Text(
                  "Show the home screen over here",
                  style: TextStyle(fontSize: 24, fontFamily: "Product Sans"),
                ),
              );
            }
          }
          else{
            return Center(
              child: SplashScreen(),
            );
          }
        },
      ),
    );
  }
}