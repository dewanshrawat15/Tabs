import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../components/colors.dart';

class DashboardScreen extends StatefulWidget{
  @override
  DasboardScreenState createState() => DasboardScreenState();
}

class DasboardScreenState extends State<DashboardScreen>{
  
  @override
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Transactions",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: ThemeColor,
          centerTitle: false,
          bottom: TabBar(
            tabs: <Widget>[
              RotationTransition(turns: AlwaysStoppedAnimation(45/360), child: Tab(icon: Icon(Icons.arrow_upward,),),),
              RotationTransition(turns: AlwaysStoppedAnimation(45/360), child: Tab(icon: Icon(Icons.arrow_downward,),),),
              Tab(icon: Icon(Icons.account_balance_wallet),)
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: RotationTransition(turns: AlwaysStoppedAnimation(45/360), child: Tab(icon: Icon(Icons.arrow_upward,),),),
            ),
            Center(
              child: RotationTransition(turns: AlwaysStoppedAnimation(45/360), child: Tab(icon: Icon(Icons.arrow_downward,),),),
            ),
            Center(
              child: Tab(icon: Icon(Icons.account_balance_wallet),),
            )
          ],
        ),
      ),
    );
  }
}