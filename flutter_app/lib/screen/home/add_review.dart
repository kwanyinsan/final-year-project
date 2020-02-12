import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddReview extends StatefulWidget {
  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {

  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentSchool;

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
              'Update your brew settings.',
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
            SizedBox(height: 10.0),
//                  Slider(
//                    value: (_currentStrength ?? userData.strength).toDouble(),
//                    activeColor: Colors.brown[_currentStrength ?? userData.strength],
//                    inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
//                    min: 100.0,
//                    max: 900.0,
//                    divisions: 8,
//                    onChanged: (val) => setState(() => _currentStrength = val.round()),
//                  ),
            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    //await DatabaseService(uid: user.uid).updateUserData(

                    //_currentSugars ?? snapshot.data.sugars,
                    //_currentName ?? snapshot.data.name,
                    //_currentStrength ?? snapshot.data.strength
                    //);
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