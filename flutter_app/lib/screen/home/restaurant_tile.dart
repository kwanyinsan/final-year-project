import 'package:flutter/material.dart';
import 'package:flutter_app/models/restaurant.dart';

class ResTile extends StatelessWidget {

  final Restaurant res;
  ResTile({ this.res });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: SizedBox (
        height: 400.0,
        child: Card(
          margin: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.deepOrange,
              backgroundImage: NetworkImage('${res.image}'),
            ),
            title: Text(res.name),
            subtitle: Text('Like: ${res.like}, Dislike: ${res.dislike}'
                '\nFood Type: ${res.type}'
                '\nPhone: ${res.phone}'
                '\nLocation: ${res.location}'
            ),
          ),
        ),
      )
    );
  }
}