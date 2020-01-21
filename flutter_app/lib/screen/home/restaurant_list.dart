import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/screen/home/restaurant_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResList extends StatefulWidget {
  @override
  _ResListState createState() => _ResListState();
}

class _ResListState extends State<ResList> {
  @override
  Widget build(BuildContext context) {

    final res = Provider.of<List<Restaurant>>(context) ?? [];

    return ListView.builder(
      itemCount: res.length,
      itemBuilder: (context, index) {
        return ResTile(res: res[index]);
      },
    );
  }
}