import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'createAccountScreen.dart';

import '../components/profile.dart';
import '../components/colors.dart';

class AccountScreen extends StatefulWidget{
  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen>{

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
        name: maps[i]['name'],
        username: maps[i]['username'],
        email: maps[i]['email'],
        photoURL: maps[i]['photoURL']
      );
    });
  });

  Future<void> deleteProfile() async{
    final Database db = await connectDatabase();
    await db.delete('accountDetails');
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: FutureBuilder(
        future: getProfile(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data.length == 0){
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/images/vector.png"),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 64, horizontal: 72),
                      child: Text(
                        "Create your account",
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
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditProfile())
                            );
                          },
                          color: ThemeColor,
                          padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 60.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Create Account",
                                  style: TextStyle(
                                    fontFamily: "Product Sans",
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
            else{
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 64, bottom: 64),
                        child: CircleAvatar(
                          radius: 108,
                          backgroundColor: ThemeColor,
                          backgroundImage: snapshot.data[0].photoURL != null ? NetworkImage(snapshot.data[0].photoURL) : null,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 32, bottom: 18),
                        child: Text(
                          snapshot.data[0].name,
                          style: TextStyle(fontSize: 32, fontFamily: "Product Sans"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "@" + snapshot.data[0].username,
                          style: TextStyle(fontSize: 22, fontFamily: "Product Sans"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 48, bottom: 24),
                        child: Text(
                          snapshot.data[0].email,
                          style: TextStyle(fontSize: 24, fontFamily: "Product Sans"),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          deleteProfile();
          Navigator.pop(context);
          setState(() {
            
          });
        },
        child: Icon(Icons.delete),
      ),
    );
  }
}