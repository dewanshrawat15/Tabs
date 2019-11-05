import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../components/record.dart';

class TransactionScreen extends StatefulWidget{
  @override
  TransactionScreenState createState() => TransactionScreenState();
}

class TransactionScreenState extends State<TransactionScreen>{

  connectDatabase() async{
    Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'records.db'),
      onCreate: (db, version){
        return db.execute(
          "CREATE TABLE recordHistory(payer TEXT, payee TEXT, amount INT, time DATETIME)",
        );
      },
      version: 1
    );
    return database;
  }

  Future<List<Record>> getRecords() async{
    final Database db = await connectDatabase();
    final List<Map<String, dynamic>> maps = await db.query('recordHistory');
    return List.generate(maps.length, (i){
      return Record(
        payer: maps[i]['payer'],
        payee: maps[i]['payee'],
        amount: maps[i]['amount'],
        time: maps[i]['time'],
      );
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transaction History"
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getRecords(),
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
              if(snapshot.hasData){
                if(snapshot.data.length != 0){
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      return InkWell(
                        onTap: (){
                          
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.red,
                            child: (snapshot.data[index].payer) != null ? Text(
                              (snapshot.data[index].payer[0]).toUpperCase(),
                              style: TextStyle(fontFamily: "Product Sans", fontSize: 20, color: Colors.white),
                            ) : Icon(Icons.credit_card, color: Colors.white,),
                          ),
                          title: (snapshot.data[index].payee) != null ? Text((snapshot.data[index].payee)) : null,
                          subtitle: (snapshot.data[index].amount) != null ? Text((snapshot.data[index].amount).toString()) : null,
                        ),
                      );
                    },
                  );
                }
              }
            }
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.add),
      ),
    );
  }
}