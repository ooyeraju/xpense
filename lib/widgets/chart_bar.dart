import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final int spendingAmount;
  final double spendingPercentOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constrains) {
        return Column(
          children: <Widget>[
//            Container(
//              height: constrains.maxHeight * 0.1,
//              child: FittedBox(
//                child: Text('Total  expense'),
//              ),
//            ),
            Container(
              height: constrains.maxHeight * 0.15,
              child: FittedBox(
                child: Text('₹$spendingAmount '),
              ),
            ),
            SizedBox(
              height: constrains.maxHeight * 0.05,
            ),
            Container(
              height: constrains.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey, width: 1),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    // alignment: Alignment.bottomCenter,
                    heightFactor: spendingPercentOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        // border: Border.all(color:Colors.grey, width: 1),
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constrains.maxHeight * 0.05,
            ),
            Container(
              height: constrains.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
