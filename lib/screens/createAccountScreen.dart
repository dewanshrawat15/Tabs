import 'package:flutter/material.dart';
import '../components/profile.dart';
import '../components/colors.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class EditProfile extends StatefulWidget{
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile>{

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

  Future<void> insertCardProfile(Account newUser) async{
    final Database db = await connectDatabase();
    await db.insert(
      'accountDetails',
      newUser.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Account user;

  final formKey = GlobalKey<FormState>();

  final namefocusnode = new FocusNode();
  final usernamefocusnode = new FocusNode();
  final emailfocusnode = new FocusNode();
  final photourlfocusnode = new FocusNode();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 64),
                child: Image.asset("assets/images/createAccount.png"),
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: TextFormField(
                        autocorrect: false,
                        autofocus: true,
                        focusNode: namefocusnode,
                        decoration: InputDecoration(
                          hintText: "For eg (Barrack Obama)",
                          icon: Icon(Icons.person_outline),
                          labelText: "Name"
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        onChanged: (nameValue){
                          user.name = nameValue;
                        },
                        onFieldSubmitted: (value){
                          namefocusnode.unfocus();
                          FocusScope.of(context).requestFocus(usernamefocusnode);
                        },
                        validator: (value){
                          if(value.isEmpty){
                            return 'This field is mandatory';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: TextFormField(
                        focusNode: usernamefocusnode,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: "For eg (dewanshrawat15)",
                          icon: Icon(Icons.alternate_email),
                          labelText: "Username"
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onChanged: (usernameValue){
                          user.username = usernameValue;
                        },
                        onFieldSubmitted: (value){
                          usernamefocusnode.unfocus();
                          FocusScope.of(context).requestFocus(emailfocusnode);
                        },
                        validator: (value){
                          if(value.isEmpty){
                            return 'This field is mandatory';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: TextFormField(
                        autocorrect: false,
                        focusNode: emailfocusnode,
                        decoration: InputDecoration(
                          hintText: "For eg (dscbvppune@gmail.com)",
                          icon: Icon(Icons.email),
                          labelText: "Email"
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onChanged: (emailValue){
                          user.email = emailValue;
                        },
                        onFieldSubmitted: (value){
                          emailfocusnode.unfocus();
                          FocusScope.of(context).requestFocus(photourlfocusnode);
                        },
                        validator: (value){
                          if(value.isEmpty){
                            return 'This field is mandatory';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: TextFormField(
                        focusNode: photourlfocusnode,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: "For eg https://bit.ly/dewanshrawatprofile",
                          icon: Icon(Icons.photo),
                          labelText: "Photo URL"
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.url,
                        onChanged: (photoURLValue){
                          user.photoURL = photoURLValue;
                        },
                        onFieldSubmitted: (value){
                          photourlfocusnode.unfocus();
                        },
                        validator: (value){
                          return null;
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print(user.toMap());
          // insertCardProfile(user);
          Navigator.pop(context);
        },
        child: Icon(Icons.chevron_right),
      ),
    );
  }
}