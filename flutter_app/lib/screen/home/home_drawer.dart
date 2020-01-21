import 'package:flutter/cupertino.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/shared/loading.dart';

class HomeDrawer extends StatelessWidget {

  final AuthService _auth = AuthService();

@override
Widget build(BuildContext context) {

  final _formKey = GlobalKey<FormState>();
  User user = Provider.of<User>(context);

  return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Scaffold(
                  drawer: Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        DrawerHeader(
                          child: Text('Team Orange App'),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                          ),
                        ),
                        ListTile(
                            leading: Icon(Icons.person),
                            title: Text('Home'),
                            onTap: () async {
                              Navigator.pop(context);
                            }
                        ),
                        ListTile(
                          leading: Icon(Icons.restaurant_menu),
                          title: Text("Reviews"),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                            leading: Icon(Icons.person),
                            title: Text('Profile'),
                            onTap: () async {
                              Navigator.pop(context);
                            }
                        ),
                        ListTile(
                            leading: Icon(Icons.exit_to_app),
                            title: Text('Logout'),
                            onTap: () async {
                              _auth.signOut();
                            }
                        ),
                      ],
                    ),
                  ), backgroundColor: Colors.deepOrange[100],
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      }
  );
}
}
