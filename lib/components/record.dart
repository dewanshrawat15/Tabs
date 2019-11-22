class Record{
  String title, description, time, type;
  int amount;

  Record({this.amount, this.description, this.title, this.time, this.type});

  Map <String, dynamic> toMap(){
    return {
      'title': title,
      'amount': amount,
      'description': description,
      'time': time,
      'type': type
    };
  }
}