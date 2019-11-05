import 'package:flutter/material.dart';
import 'registerUser.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../components/profile.dart';

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
          "CREATE TABLE accountDetails(name TEXT, username TEXT, email TEXT, title TEXT, avatarPhotoURL TEXT)",
        );
      },
      version: 1
    );
    return database;
  }

  Future<List<Person>> getProfile() async{
    final Database db = await connectDatabase();
    final List<Map<String, dynamic>> maps = await db.query('accountDetails');
    return List.generate(maps.length, (i){
      return Person(
        name: maps[i]['name'],
        username: maps[i]['username'],
        email: maps[i]['email'],
        title: maps[i]['title'],
        avatarPhotoURL: maps[i]['avatarPhotoURL']
      );
    });
  }

  Future<void> deleteProfile() async{
    final Database db = await connectDatabase();
    await db.delete('accountDetails');
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: <Widget>[
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen())
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: 14, left: 14),
              child: Icon(Icons.edit),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: getProfile(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data.length == 0){
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 48),
                      ),
                      Image.asset(
                        "assets/images/vectorAstronaut.png",
                        height: 250,
                        width: 250,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 48),
                      ),
                      Padding(
                        padding: EdgeInsets.all(36),
                        child: Text(
                          "It's empty out here. Click the pencil icon to create an account!",
                          style: TextStyle(fontSize: 20, fontFamily: "Product Sans"),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 48),
                      )
                    ],
                  ),
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
                      Padding(
                        padding: EdgeInsets.only(top: 64),
                      ),
                      CircleAvatar(
                        radius: 108,
                        backgroundImage: NetworkImage(snapshot.data[0].avatarPhotoURL),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 32),
                      ),
                      Text(
                        snapshot.data[0].name,
                        style: TextStyle(fontSize: 24, fontFamily: "Product Sans"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12),
                      ),
                      Text(
                        "@" + snapshot.data[0].username,
                        style: TextStyle(fontSize: 22, fontFamily: "Product Sans", color: Colors.red),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 32),
                      ),
                      Text(
                        snapshot.data[0].email,
                        style: TextStyle(fontSize: 18, fontFamily: "Product Sans"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 48),
                      ),
                      Text(
                        snapshot.data[0].title,
                        style: TextStyle(fontSize: 24, fontFamily: "Product Sans", color: Colors.red),
                      )
                    ],
                  ),
                )
              );
            }
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          deleteProfile();
          setState(() {
            
          });
        },
        child: Icon(Icons.delete),
      ),
    );
  }
}