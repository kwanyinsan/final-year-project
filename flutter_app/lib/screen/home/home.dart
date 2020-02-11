import 'package:flutter_app/screen/home/profile.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/screen/authenticate/authenticate.dart';
import 'package:flutter_app/screen/home/restaurant_list.dart';
import 'package:flutter_app/shared/dialogbox.dart';



class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String appBarTitle = 'Home';
  Widget widgetForBody = ResList();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
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
                onTap: () {
                  setState((){
                    widgetForBody = ResList();
                    appBarTitle = 'Home';
                  });
                  Navigator.pop(context);
                }),
            ListTile(
                leading: Icon(Icons.restaurant_menu),
                title: Text("Reviews"),
                onTap: () async {
                  Navigator.pop(context);
                }),
            ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () async{
                  Navigator.pop(context);
                  if (user != null) {
                    setState((){
                      widgetForBody = Profile();
                      appBarTitle = 'Profile';
                    });
                  } else {
                    // TODO: add alert
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Authenticate()),
                    );
                    showAlertDialog(context);
                    print('error: user have not signed in');
                  }
                }),
            ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {

                  Navigator.pop(context);
                }),
            LoginLogout(),
          ],
        ),
      ),
      backgroundColor: Colors.deepOrange[100],
      appBar: AppBar(
        title: Text(appBarTitle),
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
      body: widgetForBody,
      floatingActionButton: AddMenu(),
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
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
            _auth.signOut();
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

class AddMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: PopupMenuButton<String>(
        onSelected: choiceAction,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>> [
          const PopupMenuItem<String>(
            value: 'addRes',
            child: Text('Add a Restaurant'),
          ),
          const PopupMenuItem<String>(
            value: 'addReview',
            child: Text('Add a Review'),
          ),
        ],
        icon: Icon(Icons.add),
      ),
      backgroundColor: Colors.deepOrange,
    );
  }

  void choiceAction(String choice) {
    print('working');
  }
}