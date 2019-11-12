import 'package:flutter/material.dart';
import 'createAccountScreen.dart';

class AccountScreen extends StatefulWidget{
  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends State<AccountScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditProfile())
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}