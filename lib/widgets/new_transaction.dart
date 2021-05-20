import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  DateTime _selectPickedDate;
  final _amountController = TextEditingController();

  void _submitdata() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final entrerdTitle = _titleController.text;
    final entreedamount = double.parse(_amountController.text);

    if (entrerdTitle.isEmpty ||
        entreedamount <= 0 ||
        _selectPickedDate == null) {
      return;
    }
    widget.addTx(
      _titleController.text,
      double.parse(_amountController.text),
      _selectPickedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedData) {
      if (pickedData == null) {
        return;
      }
      setState(() {
        _selectPickedDate = pickedData;
        print(_selectPickedDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitdata(),
                // onChanged: (val) {
                //   titleInput = val;
                //  },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitdata(),
                // onChanged: (val) => amountInput,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Text(_selectPickedDate == null
                        ? 'no date chosen !'
                        : DateFormat.yMd().format(_selectPickedDate)),
                    FlatButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'choose date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Colors.blue,
                    )
                  ],
                ),
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text('Add Transaction'),
                onPressed: () => _submitdata(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
