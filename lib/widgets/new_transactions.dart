// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  NewTransaction(
      this.addNewTransaction); // constructor for this NewTransaction widget.
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    // final chosenDate = _selectedDate;

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    if (_selectedDate == null) {
      _selectedDate = DateTime.now();
    }
    widget.addNewTransaction(
      _titleController.text,
      int.parse(_amountController.text),
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        // _selectedDate = DateTime.now();
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  final focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                onSubmitted: (_) => FocusScope.of(context).requestFocus(
                    focus), // submit button press take you to next text input field.
              ),
              TextField(
                focusNode: focus,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? DateFormat.yMMMd().format(DateTime.now())
                            : DateFormat.yMMMd().format(_selectedDate),
                      ),
                    ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    FlatButton(
                      child: Text('Choose Date'),
                      textColor: Theme.of(context).accentColor,
                      onPressed: _presentDatePicker,
                    ),
                  ],
                ),
              ),
              FlatButton(
                child: Text('Add Transaction'),
                textColor: Colors.white,
                onPressed: _submitData,
                color: Theme.of(context).primaryColorDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
