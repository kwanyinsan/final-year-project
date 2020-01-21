import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/screen/home/restaurant_list.dart';
import 'package:flutter_app/screen/home/settings_form.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Restaurant>>.value(
      value: DatabaseService().res,
      child: Scaffold(
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
                  leading: Icon(Icons.home),
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
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
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
        ),
        backgroundColor: Colors.deepOrange[100],
        appBar: AppBar(
          title: Text('Restaurants'),
          backgroundColor: Colors.deepOrange,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.search),
              label: Text(''),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(''),
                fit: BoxFit.cover,
              ),
            ),
            child: ResList()
        ),
      ),
    );
  }
}

