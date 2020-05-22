import 'package:flutter/material.dart';

import '../models/transactions.dart';

class TotalExpenditure extends StatelessWidget {
  final List<Transaction> totalTransaction;

  TotalExpenditure(this.totalTransaction);
  int get totalExpenditure {
    int sum = 0;
    for (var i = 0; i < totalTransaction.length; i++) {
      sum += totalTransaction[i].amount;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Theme.of(context).primaryColorLight,
      child: Text(
        'Total : $totalExpenditure',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
