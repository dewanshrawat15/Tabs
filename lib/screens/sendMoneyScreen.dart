import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tabs/components/colors.dart';

import '../components/record.dart';
import 'sendMoney.dart';

class SendMoneyScreen extends StatelessWidget{

  connectDatabase() async{
    Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'records.db'),
      onCreate: (db, version){
        return db.execute(
          "CREATE TABLE recordDetails(title TEXT, amount NUMBER, description TEXT, time TEXT, type TEXT)",
        );
      },
      version: 1
    );
    return database;
  }

  Future<List<Record>> getSentTransactions() async => await Future.delayed(Duration(milliseconds: 1400), () async {
    final Database db = await connectDatabase();
    final List<Map<String, dynamic>> maps = await db.query('recordDetails');
    return List.generate(maps.length, (i){
      return Record(
        title: maps[i]['title'],
        description: maps[i]['description'],
        amount: maps[i]['amount'],
        time: maps[i]['time'],
        type: maps[i]['type']
      );
    });
  });

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: getSentTransactions(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        print(snapshot.data);
        if(snapshot.hasData){
          if(snapshot.data.length == 0){
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    "Make a transaction",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Product Sans"
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 18),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: FlatButton.icon(
                      padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                      label: Text(
                        "Send money",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Product Sans",
                          fontSize: 16.0
                        ),
                      ),
                      color: ThemeColor,
                      onPressed: (){},
                      icon: RotationTransition(turns: AlwaysStoppedAnimation(45/360), child: Tab(icon: Icon(Icons.arrow_upward, color: Colors.white,),),),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: FlatButton.icon(
                      padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                      label: Text(
                        "Recieve money",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Product Sans",
                          fontSize: 16.0
                        ),
                      ),
                      color: ThemeColor,
                      onPressed: (){},
                      icon: RotationTransition(turns: AlwaysStoppedAnimation(45/360), child: Tab(icon: Icon(Icons.arrow_downward, color: Colors.white,),),),
                    ),
                  )
                ],
              ),
            );
          }
          else{
            return Text("Loading your money");
          }
        }
        else{
          return CircularProgressIndicator();
        }
      },
    );
  }
}