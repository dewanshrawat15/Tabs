class Account{
  String name, username, email, photoURL;

  // Constructor
  Account({this.name, this.username, this.email, this.photoURL});

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'username': username,
      'email': email,
      'photoURL': photoURL
    };
  }

}