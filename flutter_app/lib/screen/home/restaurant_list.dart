import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/shared/loading.dart';
import 'package:flutter_app/screen/home/restaurant_page.dart';

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


class ResTile extends StatelessWidget {

  final Restaurant res;
  ResTile({ this.res });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 3),
      child: Card(
        margin: EdgeInsets.zero,
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.deepOrange,
            backgroundImage: NetworkImage('${res.image}'),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          title: Text('${res.name}'),
          subtitle: Text('Like: ${res.like}, Dislike: ${res.dislike}'
              '\nFood Type: ${res.type}'
              '\nPhone: ${res.phone}'
              '\nLocation: ${res.location}'
              '\nRestaurant ID: ${res.restaurant_id}'
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResPage(res: res)),
            );
          },
        ),
      ),
    );
  }
}