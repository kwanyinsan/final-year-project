import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/constants.dart';
import 'package:flutter_app/shared/loading.dart';

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
  String school = 'HKU SPACE';

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
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            children: <Widget>[
              Center(
                child: Image.network('https://i.imgur.com/gTp3dlW.png', height: 100, width: 100),
              ),
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
              Center(
                child: RaisedButton(
                    color: Colors.deepOrange,
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate() && email.contains("@learner.hkuspace.hku.hk")){
                        setState(() => loading = true);
                        dynamic result = await _auth.registerWithEmailAndPassword(email, password, name, school, 'https://i.imgur.com/GcqJ5NM.png');
                        if (result != null) {
                          print(" >>> Register Action $email");
                          Navigator.of(context).pop();
                        } else
                        if(result == null) {
                          setState(() {
                            loading = false;
                            error = 'Please supply a valid email or this email have been used.';
                          });
                        }
                      } else
                        setState(() {
                          loading = false;
                          error = 'You must be a HKUSPACE student to register.';
                        });
                    }
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Row(
                  children: <Widget>[
                    Spacer(),
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.black), textAlign: TextAlign.center,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.toggleView();
                      },
                      child: Text(
                        "Login Here.",
                        style: TextStyle(color: Colors.deepOrange), textAlign: TextAlign.center,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}