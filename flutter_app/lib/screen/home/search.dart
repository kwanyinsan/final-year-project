import 'package:flutter/material.dart';
import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/screen/home/restaurant_page/restaurant_page.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';

class DataSearch extends SearchDelegate<String> {

  @override
  String get searchFieldLabel => "Search";

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
      primaryColor: Colors.deepOrange,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
      inputDecorationTheme: InputDecorationTheme(hintStyle: TextStyle(color: Colors.white)),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {

    if (query.isEmpty) {
      return Text('Recent Search');
    }

    return StreamBuilder(
      stream: DatabaseService().res,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Restaurant> res = snapshot.data;
          List<Restaurant> results = res.where((a) => a.name.contains(query)).toList();
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: ResultTile(res: results[index]),
                // children: results.map<Widget>((a) => Text(a.data['title'].toString())).toList()
              );
            },
          );
        } else {
          return Loading();
        }
      },
    );
  }
}


class ResultTile extends StatelessWidget {
  final Restaurant res;
  ResultTile({this.res});

  @override
  Widget build(BuildContext context) {


    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResPage(res: res)),
        );
      },
      leading: CircleAvatar(
        backgroundColor: Colors.deepOrange[100],
        backgroundImage: NetworkImage(res.image),
      ),
      title: Text(res.name),
      subtitle: Text(res.location.toString())
    );
  }

  getAddress() async {
    final coordinates = new Coordinates(1.10, 45.50);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
    return '${first.featureName}';
  }
}
