import 'package:flutter/material.dart';
import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/screen/home/restaurant_page.dart';

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