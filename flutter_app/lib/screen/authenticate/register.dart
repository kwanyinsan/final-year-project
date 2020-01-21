import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String name = '';
  String school = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.deepOrange[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0.0,
        title: Text('Register', textAlign: TextAlign.center),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => widget.toggleView(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              Text(' E-mail', textAlign: TextAlign.left,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val.trim());
                },
              ),
              SizedBox(height: 10.0),
              Text(' Password', textAlign: TextAlign.left,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val.trim());
                },
              ),
              SizedBox(height: 10.0),
              Text(' Name', textAlign: TextAlign.left,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'name'),
                validator: (val) => val.isEmpty ? 'Enter an name' : null,
                onChanged: (val) {
                  setState(() => name = val.trim());
                },
              ),
              SizedBox(height: 10.0),
              Text(' School', textAlign: TextAlign.left,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'school'),
                validator: (val) => val.isEmpty ? 'Enter an school name' : null,
                onChanged: (val) {
                  setState(() => school = val.trim());
                },
              ),
              SizedBox(height: 5.0),
              RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password, name, school);
                      if(result == null) {
                        setState(() {
                          loading = false;
                          error = 'Please supply a valid email';
                        });
                      }
                    }
                  }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}