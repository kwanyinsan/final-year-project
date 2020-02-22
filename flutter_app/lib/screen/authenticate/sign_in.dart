import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.deepOrange[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0.0,
        title: Text('Team Orange App'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.info),
            label: Text('Register'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              Text(' E-mail', textAlign: TextAlign.left,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'email'),
                validator: (val) => val.isEmpty ? 'Please enter your email.' : null,
                onChanged: (val) {
                  setState(() => email = val.trim());
                },
              ),
              SizedBox(height: 10.0),
              Text(' Password', textAlign: TextAlign.left,),
              TextFormField(
                obscureText: true,
                decoration: textInputDecoration.copyWith(hintText: 'password'),
                validator: (val) => val.length < 6 ? 'Please enter a 6+ chars long password' : null,
                onChanged: (val) {
                  setState(() => password = val.trim());
                },
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                  color: Colors.deepOrange,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null) {
                        setState(() {
                          loading = false;
                          error = 'Could not sign in with those credentials';
                        });
                      } else
                      Navigator.pop(context);
                      // TODO: add alert
                      print('login successfully');
                    }
                  }
              ),

              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Column buildButton(String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.deepOrange,
            ),
          ),
        ),
      ],
    );
  }
}