import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:tabs/components/drawer.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget{
  @override
  HomeScreenState createState() => HomeScreenState();
}

bool themeState = true;

class HomeScreenState extends State<HomeScreen>{

  connectDatabase() async{
    Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'records.db'),
      onCreate: (db, version){
        return db.execute(
          "CREATE TABLE recordHistory(payer TEXT, payee TEXT, amount INT, time TEXT)",
        );
      },
      version: 1
    );
    return database;
  }

  Future<List<Map<String, dynamic>>> getCredit() async{
    final Database db = await connectDatabase();
    var result = db.rawQuery('SELECT SUM(amount) as CREDIT FROM recordHistory where amount > 0');
    return result;
  }

  Future<List<Map<String, dynamic>>> getDebit() async{
    final Database db = await connectDatabase();
    var result = db.rawQuery('SELECT SUM(amount) as DEBIT FROM recordHistory where amount < 0');
    return result;
  }

  @override
  void initState() {
    setState(() {
      
    });
    super.initState();
  }

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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 32, left: 20),
                child: FutureBuilder(
                  future: getCredit(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(snapshot.hasData){
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.deepOrange,
                          child: Icon(Icons.attach_money, color: Colors.white,),
                        ),
                        title: Text("Money you get back"),
                        subtitle: Text(
                          (snapshot.data[0]['CREDIT']).toString(),
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: "Product Sans"
                          ),
                        ),
                      );
                    }
                    else{
                      return Text("Give loans to see them over here.");
                    }
                  }
                )
              ),
              Padding(
                padding: EdgeInsets.only(top: 32, left: 20),
                child: FutureBuilder(
                  future: getDebit(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if(snapshot.hasData){
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.deepOrange,
                          child: Icon(Icons.attach_money, color: Colors.white,),
                        ),
                        title: Text("Money you have to pay"),
                        subtitle: Text(
                          (-snapshot.data[0]['DEBIT']).toString(),
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: "Product Sans"
                          ),
                        ),
                      );
                    }
                    else{
                      return Text("Take loans to see them over here.");
                    }
                  }
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}