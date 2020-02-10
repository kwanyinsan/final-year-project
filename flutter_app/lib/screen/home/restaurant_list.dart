import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/screen/home/restaurant_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/loading.dart';

class ResList extends StatefulWidget {
  @override
  _ResListState createState() => _ResListState();
}

class _ResListState extends State<ResList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService().res,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Restaurant> res = snapshot.data;
          return ListView.builder(
            itemCount: res.length,
            itemBuilder: (context, index) {
              return ResTile(res: res[index]);
            },
          );
        } else {
          return Loading();
        }
      },
    );
  }
}