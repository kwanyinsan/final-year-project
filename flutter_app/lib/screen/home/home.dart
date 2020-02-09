import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/screen/authenticate/authenticate.dart';


class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: HomeDrawer(),
      backgroundColor: Colors.deepOrange[100],
      appBar: AppBar(
        title: Text('Restaurants'),
        backgroundColor: Colors.deepOrange,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.search),
            label: Text(''),
            onPressed: () => print("search press"),
          )
        ],
      ),
      body: BuildResList()
    );
  }
}

class BuildResList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance.collection('restaurant').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return new ListView(
            children: snapshot.data.documents.map((res) {
              return new ListTile(
                title: Text(res['name']),
                subtitle: Text(res['type']),
              );
            }).toList(),
          );
        } else {
          return new Text("Loading...");
        }
      },
    );
  }
}

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        return Drawer(
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
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () async {
                    Navigator.pop(context);
                  }),
              ListTile(
                  leading: Icon(Icons.restaurant_menu),
                  title: Text("Reviews"),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  onTap: () async {
                    Navigator.pop(context);
                  }),
              ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () async {
                    Navigator.pop(context);
                  }),
              LoginLogout(),
            ],
          ),
        );
      }
}

class LoginLogout extends StatefulWidget {
  @override
  _LoginLogoutState createState() => _LoginLogoutState();
}

class _LoginLogoutState extends State<LoginLogout> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user != null) {
      return ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () async {
            _auth.signOut();
          });
    } else
      return ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Login'),
          onTap: () {
            return Authenticate();
          });
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder(
        stream: Firestore.instance.collection('userdata').document(user.uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userData = snapshot.data;
          return Text(userData['name']);
        });
  }
}