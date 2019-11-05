import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../components/profile.dart';

class EditProfileScreen extends StatefulWidget{
  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen>{

  bool passForm = false;

  FocusNode nameFocusNode;
  FocusNode usernameFocusNode;
  FocusNode emailFocusNode;
  FocusNode titleFocusNode;

  FocusNode photoURLFocusNode;

  FocusNode passwordFocusNode;
  FocusNode rePasswordFocusNode;

  var database;
  Person basicProfile;

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

  Future<void> updateProfile(Person basicPerson) async{
    final Database db = await connectDatabase();
    await db.insert(
      'accountDetails',
      basicPerson.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> deleteProfile() async{
    final Database db = await connectDatabase();
    await db.delete('accountDetails');
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

  @override
  void initState() {

    basicProfile = Person();

    super.initState();

    nameFocusNode = FocusNode();
    usernameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    titleFocusNode = FocusNode();
    photoURLFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    rePasswordFocusNode = FocusNode();
  }

  @override
  void dispose(){
    nameFocusNode.dispose();
    usernameFocusNode.dispose();
    emailFocusNode.dispose();
    titleFocusNode.dispose();
    photoURLFocusNode.dispose();
    passwordFocusNode.dispose();
    rePasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit my profile"),
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
                focusNode: nameFocusNode,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange, width: 1.0),
                  ),
                  icon: Icon(Icons.account_circle, color: Colors.deepOrange),
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.deepOrange),
                ),
                onChanged: (nameData){
                  if(nameData.length == 0){
                    passForm = false;
                  }
                  else{
                    passForm = true;
                  }
                  basicProfile.name = nameData;
                },
                onEditingComplete: (){
                  nameFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(usernameFocusNode);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: TextField(
                focusNode: usernameFocusNode,
                keyboardType: TextInputType.text,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange, width: 1.0),
                  ),
                  icon: Icon(Icons.text_fields, color: Colors.deepOrange),
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.deepOrange),
                ),
                onChanged: (usernameData){
                  if(usernameData.length == 0){
                    passForm = false;
                  }
                  else{
                    passForm = true;
                  }
                  basicProfile.username = usernameData;
                },
                onEditingComplete: (){
                  usernameFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(emailFocusNode);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: TextField(
                focusNode: emailFocusNode,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange, width: 1.0),
                  ),
                  icon: Icon(Icons.email, color: Colors.deepOrange),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.deepOrange),
                ),
                onChanged: (emailIDData){
                  if(emailIDData.length == 0){
                    passForm = false;
                  }
                  else{
                    passForm = true;
                  }
                  basicProfile.email = emailIDData;
                },
                onEditingComplete: (){
                  emailFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(titleFocusNode);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: TextField(
                focusNode: titleFocusNode,
                autocorrect: false,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange, width: 1.0),
                  ),
                  icon: Icon(Icons.title, color: Colors.deepOrange),
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.deepOrange),
                ),
                onChanged: (titleData){
                  if(titleData.length == 0){
                    passForm = false;
                  }
                  else{
                    passForm = true;
                  }
                  basicProfile.title = titleData;
                },
                onEditingComplete: (){
                  titleFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(photoURLFocusNode);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: TextField(
                focusNode: photoURLFocusNode,
                autocorrect: false,
                keyboardType: TextInputType.url,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange, width: 1.0),
                  ),
                  icon: Icon(Icons.image, color: Colors.deepOrange),
                  labelText: 'Avatar URL',
                  labelStyle: TextStyle(color: Colors.deepOrange),
                ),
                onChanged: (photoTextData){
                  if(photoTextData.length == 0){
                    passForm = false;
                  }
                  else{
                    passForm = true;
                  }
                  basicProfile.avatarPhotoURL = photoTextData;
                },
                onEditingComplete: (){
                  photoURLFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(passwordFocusNode);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: TextField(
                focusNode: passwordFocusNode,
                autocorrect: false,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange, width: 1.0),
                  ),
                  icon: Icon(Icons.lock, color: Colors.deepOrange),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.deepOrange),
                ),
                obscureText: true,
                onChanged: (passwordTextData){
                  if(passwordTextData.length == 0){
                    passForm = false;
                  }
                  else{
                    passForm = true;
                  }
                  basicProfile.password = passwordTextData;
                },
                onEditingComplete: (){
                  passwordFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(rePasswordFocusNode);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: TextField(
                focusNode: rePasswordFocusNode,
                autocorrect: false,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  enabledBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: new UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange, width: 1.0),
                  ),
                  icon: Icon(Icons.lock, color: Colors.deepOrange),
                  labelText: 'Password Again',
                  labelStyle: TextStyle(color: Colors.deepOrange),
                ),
                obscureText: true,
                onChanged: (rePasswordTextData){
                  if(rePasswordTextData.length == 0){
                    passForm = false;
                  }
                  else{
                    passForm = true;
                  }
                  basicProfile.rePassword = rePasswordTextData;
                },
                onEditingComplete: (){
                  rePasswordFocusNode.unfocus();
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(basicProfile.password == basicProfile.rePassword && passForm){
            // deleteProfile();
            deleteProfile();
            updateProfile(basicProfile);
            Navigator.of(context).pop();
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