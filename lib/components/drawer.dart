import 'package:flutter/material.dart';
import '../screens/profileScreen.dart';

class SlideInDrawer extends StatelessWidget{
  bool themeState;
  
  SlideInDrawer({this.themeState});

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepOrange,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Text(
                "Tabs",
                style: TextStyle(fontSize: 24, fontFamily: "Product Sans", color: Colors.white),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountScreen())
              );
            },
            child: ListTile(
              title: Text(
                "My Profile",
                style: TextStyle(fontSize: 20, fontFamily: "Product Sans"),
              ),
              leading: Icon(Icons.account_circle, color: themeState ? Colors.black : Colors.white,),
            ),
          )
        ],
      ),
    );
  }
}