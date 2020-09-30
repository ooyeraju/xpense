import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:flutter/services.dart';

import './models/transactions.dart';
import './widgets/new_transactions.dart';
import './widgets/transactions_list.dart';
import './widgets/charts.dart';
import './widgets/total_exp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xpenses',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

 
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  List<Transaction> get _totalTranscations {
    return _userTransactions;
  }

  void _addNewTransaction(String txTitle, int txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  bool _showChart = false;

  @override
  void initState(){
    WidgetsBinding.instance.addObserver(this); 
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    print(state);
  }

  @override
  dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Widget> _buildLanscapeContent(
    double screenHeight,
    Widget transactionList,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Show Chart'),
          Switch(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          )
        ],
      ),
      _showChart
          ? Container(
              height: screenHeight * 0.7,
              child: Charts(_recentTransactions),
            )
          : transactionList,
    ];
  }

  List<Widget> _buildPotraitContent(
    Widget totalAmount,
    double screenHeight,
    Widget transactionList,
  ) {
    return [
      totalAmount,
      Container(
        height: screenHeight * 0.3,
        child: Charts(_recentTransactions),
      ),
      transactionList,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaScreen = MediaQuery.of(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'Xpenses',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
    
    final screenHeight = (mediaScreen.size.height -
        appBar.preferredSize.height -
        mediaScreen.padding.top -
        mediaScreen.padding.bottom);

    final transactionList = Container(
      height: screenHeight * 0.65,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    final totalAmount = Container(
      padding: EdgeInsets.symmetric(horizontal: 9),
      child: TotalExpenditure(_totalTranscations),
      height: screenHeight * 0.05,
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              ..._buildLanscapeContent(
                screenHeight,
                transactionList,
              ),
            if (!isLandscape)
              ..._buildPotraitContent(
                totalAmount,
                screenHeight,
                transactionList,
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // elevation: 5.2,
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
