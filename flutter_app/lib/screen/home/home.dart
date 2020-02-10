import 'package:flutter_app/screen/home/profile.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/screen/authenticate/authenticate.dart';
import 'package:flutter_app/screen/home/restaurant_list.dart';


class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: HomeDrawer(),
      backgroundColor: Colors.deepOrange[100],
      appBar: AppBar(
        title: Text('Home'),
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
      body: ResList()
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
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

class LoginLogout extends StatelessWidget {
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
            Navigator.pop(context);
          });
    } else
      return ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Login'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Authenticate()),
            );
          });
  }
}