import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screen/home/add/add_restaurant.dart';
import 'package:flutter_app/screen/home/add/add_review.dart';
import 'package:flutter_app/screen/home/restaurant_list.dart';

enum PageEnum {
  firstPage,
  secondPage,
}

class AddButton extends StatefulWidget {
  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  _onSelect(PageEnum value) {
    switch (value) {
      case PageEnum.firstPage:
        Navigator.of(context).push(
            CupertinoPageRoute(builder: (BuildContext context) => AddRes()));
        break;
      case PageEnum.secondPage:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => AddReview()));
        break;
      default:
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => ResList()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.deepOrange,
      onPressed: () {},
      child: PopupMenuButton<PageEnum>(
        onSelected: _onSelect,
        child: Icon(Icons.add),
        itemBuilder: (context) => <PopupMenuEntry<PageEnum>>[
          PopupMenuItem<PageEnum>(
            value: PageEnum.firstPage,
            child: Row(
              children: <Widget>[
                Icon(Icons.restaurant, color: Colors.deepOrange,),
                SizedBox(width: 10),
                Text('Add a Restaurant', style: TextStyle(color: Colors.deepOrange))
              ],
            ),
          ),
          PopupMenuItem<PageEnum>(
            value: PageEnum.secondPage,
            child: Row(
              children: <Widget>[
                Icon(Icons.rate_review, color: Colors.deepOrange,),
                SizedBox(width: 10),
                Text('Write a Review', style: TextStyle(color: Colors.deepOrange))
              ],
            ),
          ),
        ]
    ));
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
    );
  }
}