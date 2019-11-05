class Person{
  // Basic Details
  String name;
  String username;
  String email;
  String title;
  // Photos
  String avatarPhotoURL;
  // Passwords
  String password;
  String rePassword;
  
  // Constructor
  Person({this.name, this.username, this.email, this.title, this.avatarPhotoURL, this.password, this.rePassword});

  Map <String, dynamic> toMap(){
    return {
      'name': name,
      'username': username,
      'email': email,
      'title': title,
      'avatarPhotoURL': avatarPhotoURL
    };
  }
}