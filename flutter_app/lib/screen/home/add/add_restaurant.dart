import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/constants.dart';

class AddRes extends StatefulWidget {

  @override
  _AddResState createState() => _AddResState();
}

class _AddResState extends State<AddRes> {
  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentAvatar;
  int _currentPrice;
  String _currentType;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text("Add Review"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              'Add a new Restaurant',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              initialValue: '',
              decoration: textInputDecoration,
              validator: (val) => val.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) => setState(() => _currentName = val),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              initialValue: '',
              decoration: textInputDecoration,
              validator: (val) => val.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) => setState(() => _currentAvatar = val),
            ),
            SizedBox(height: 10.0),
            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    await DatabaseService().newRes('name_addtest', 'type_addtest', 00000000, new GeoPoint(0, 0), 0, 0, 'https://i.imgur.com/gTp3dlW.png');
                    Navigator.pop(context);
                  }
                }
                ),
                  ],
                ),
              ),
    );
        }
}