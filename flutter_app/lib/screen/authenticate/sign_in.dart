import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

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
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.deepOrange[100],
            appBar: AppBar(
              backgroundColor: Colors.deepOrange,
              elevation: 0.0,
              title: Text('Login'),
            ),
            body: Container(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                  children: <Widget>[
                    Center(
                      child: Image.network('https://i.imgur.com/gTp3dlW.png',
                          height: 100, width: 100),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      ' E-mail',
                      textAlign: TextAlign.left,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'email'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter your email.' : null,
                      onChanged: (val) {
                        setState(() => email = val.trim());
                      },
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      ' Password',
                      textAlign: TextAlign.left,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'password'),
                      validator: (val) => val.length < 6
                          ? 'Please enter a 6+ chars long password'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val.trim());
                      },
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: <Widget>[
                        Spacer(),
                        Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.black, fontSize: 14.0),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Center(
                      child: RaisedButton(
                          color: Colors.deepOrange,
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      'Could not sign in with those credentials';
                                });
                              } else {
                                print(" >>> Login Action $email");
                                Navigator.of(context).pop();
                              }
                            }
                          }),
                    ),
                    SizedBox(height: 5),
                    Center(
                      child: Row(
                        children: <Widget>[
                          Spacer(),
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggleView();
                            },
                            child: Text(
                              "Register Here.",
                              style: TextStyle(color: Colors.deepOrange),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
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
