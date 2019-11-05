class Record{
  String payer;
  String payee;
  int amount;
  String time;

  Record({this.payer, this.payee, this.amount, this.time});

  Map <String, dynamic> toMap(){
    return {
      'payer': payer,
      'payee': payee,
      'amount': amount,
      'time': time
    };
  }

}