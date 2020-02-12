import 'package:flutter/material.dart';
import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/screen/home/restaurant_page/restaurant_page.dart';
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

class ResTile extends StatelessWidget {
  final Restaurant res;
  ResTile({this.res});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 3),
      child: Material(
        color: Colors.white,
        child: InkWell(
          splashColor: Colors.deepOrange,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResPage(res: res)),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('${res.image}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.restaurant_menu),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    '${res.name}',
                    style: Theme.of(context).textTheme.headline,
                  ),
                ],
              ),
              Text('Like: ${res.like}, Dislike: ${res.dislike}'
                  '\nFood Type: ${res.type}'
                  '\nPhone: ${res.phone}'
                  '\nPrice: ${res.price}'
                  '\nLocation: Lat:${res.location.latitude}, Long:${res.location.longitude}'
                  '\nRestaurant ID: ${res.restaurant_id}'),
            ],
          ),
        ),
      ),
    );
  }
}