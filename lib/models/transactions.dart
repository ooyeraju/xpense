class Transaction {
  final String id;
  final String title;
  final int amount;
  final DateTime date;

  Transaction({
    this.id,
    this.title,
    this.amount,
    this.date,
  });

  Transaction.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        title = json['title'],
        amount = json['amount'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'amount': amount,
        'date': date,
      };
}
