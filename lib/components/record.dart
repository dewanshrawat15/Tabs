class Record{
  String title, description, time;
  int amount;

  Record(this.amount, this.description, this.title, this.time);

  Map <String, dynamic> toMap(){
    return {
      'title': title,
      'amount': amount,
      'description': description,
      'time': time,
    };
  }
}