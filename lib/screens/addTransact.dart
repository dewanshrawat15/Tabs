import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../components/record.dart';

bool passForm = false;

class AddTransactionRecord extends StatefulWidget{
  @override
  AddTransactionRecordState createState() => AddTransactionRecordState();
}

class AddTransactionRecordState extends State<AddTransactionRecord>{

  FocusNode payerFocusNode;
  FocusNode amountFocusNode;
  FocusNode payeeFocusNode;
  FocusNode timeDateFocusNode;

  Record record;

  var database;
  
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

  Future<void> insertRecord(Record record) async{
    final Database db = await connectDatabase();
    await db.insert(
      'recordHistory',
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> deleteProfile() async{
    final Database db = await connectDatabase();
    await db.delete('paymentsProfile');
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("Please check the details once again."),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        )
    );
  }

  String dropdownValue = 'Paid to you';

  @override
  void initState() {
    super.initState();

    record = Record();

    payerFocusNode = FocusNode();
    amountFocusNode = FocusNode();
    payeeFocusNode= FocusNode();
    timeDateFocusNode = FocusNode();
  }

  @override
  void dispose() {
    payerFocusNode.dispose();
    amountFocusNode.dispose();
    payeeFocusNode.dispose();
    timeDateFocusNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Payment Method"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: TextField(
                autofocus: true,
                autocorrect: false,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  icon: Icon(Icons.account_circle, color: Colors.red),
                  labelText: 'Payer',
                  labelStyle: TextStyle(color: Colors.red),
                ),
                onChanged: (payerData){
                  if(payerData.length == 0 || payerData == null){
                    passForm = false;
                  }
                  else{
                    passForm = true;
                    record.payer = payerData;
                  }
                },
                onEditingComplete: (){
                  payerFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(payeeFocusNode);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: TextField(
                focusNode: payeeFocusNode,
                autocorrect: false,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  icon: Icon(Icons.account_circle, color: Colors.red),
                  labelText: 'Payee',
                  labelStyle: TextStyle(color: Colors.red),
                ),
                onChanged: (payeeData){
                  if(payeeData == null || payeeData.length == 0){
                    passForm = false;
                  }
                  else{
                    passForm = true;
                    record.payee = payeeData;
                  }
                },
                onEditingComplete: (){
                  payeeFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(amountFocusNode);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: TextField(
                focusNode: amountFocusNode,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  icon: Icon(Icons.attach_money, color: Colors.red),
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: Colors.red),
                ),
                onChanged: (amountData){
                  if(amountData == null){
                    passForm = false;
                  }
                  else{
                    passForm = true;
                    record.amount = int.parse(amountData);
                  }
                },
                onEditingComplete: (){
                  amountFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(timeDateFocusNode);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: TextField(
                focusNode: timeDateFocusNode,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                  ),
                  icon: Icon(Icons.calendar_today, color: Colors.red),
                  labelText: 'Date / Time',
                  labelStyle: TextStyle(color: Colors.red),
                ),
                onChanged: (dateTimeData){
                  if(dateTimeData == null){
                    passForm = false;
                  }
                  else{
                    passForm = true;
                    record.time = dateTimeData;
                  }
                },
                onEditingComplete: (){
                  timeDateFocusNode.unfocus();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 32),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_drop_down_circle, color: Colors.deepOrange,),
                iconSize: 28,
                elevation: 16,
                style: TextStyle(
                  color: Colors.deepOrange
                ),
                underline: Container(
                  height: 2,
                  color: Colors.deepOrangeAccent,
                ),
                onChanged: (String val){
                  if(val == 'Paid to you'){
                    record.amount = record.amount;
                  }
                  else if(val == 'Paid by you'){
                    record.amount = -record.amount;
                  }
                  else{
                    record.amount = ((record.amount) / 2) as int;
                  }
                  setState(() {
                    dropdownValue = val;
                  });
                },
                items: <String>['Paid to you', 'Paid by you', 'Split between you'].map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(fontSize: 20, fontFamily: "Product Sans"),)
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(passForm){
            insertRecord(record);
            Navigator.pop(context);
          }
          else{
            _showAlert(context);
          }
        },
        child: Icon(Icons.chevron_right),
      ),
    );
  }
}