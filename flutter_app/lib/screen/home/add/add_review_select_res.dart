import 'package:flutter/material.dart';
import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/screen/home/add/add_review.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/loading.dart';

class SelectRes extends SearchDelegate<String> {

  @override
  String get searchFieldLabel => "Select a restaurant.";

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return theme.copyWith(
      primaryColor: Colors.deepOrange,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: Typography().white,
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
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text('Please enter select a restaurant.'),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {


    return StreamBuilder(
      stream: DatabaseService().res,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Restaurant> res = snapshot.data;
          List<Restaurant> results = res.where((a) => a.name.contains(query)).toList();
          return ListView.separated(
            itemCount: results.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: ResultTile(res: results[index]),
                // children: results.map<Widget>((a) => Text(a.data['title'].toString())).toList()
              );
            },
            separatorBuilder: (context, index) {
              return Divider(thickness: 2);
            },
          );
        } else {
          return Loading();
        }
      },
    );
  }
}

class ResultTile extends StatefulWidget {

  final Restaurant res;
  ResultTile({this.res});

  @override
  _ResultTileState createState() => _ResultTileState();
}

class _ResultTileState extends State<ResultTile> {
  String _location = '';

  @override
  void initState() {
    widget.res.getAddress().then(updateLocation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddReview(res: widget.res)),
        );
      },
      leading: CircleAvatar(
        backgroundColor: Colors.deepOrange[100],
        backgroundImage: NetworkImage(widget.res.image),
      ),
      title: Text(widget.res.name),
      subtitle: Text(_location),
    );
  }

  void updateLocation(String location) {
    setState(() {
      this._location = location.split(',')[1].trim();
    });
  }
}