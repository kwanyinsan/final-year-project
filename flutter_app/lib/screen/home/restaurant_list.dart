import 'package:flutter/material.dart';
import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/screen/home/restaurant_page/google_map.dart';
import 'package:flutter_app/screen/home/restaurant_page/restaurant_page.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_tags/tag.dart';


final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
List<String> _getAllItem(){
  List<String> returnList = [];
  List<Item> lst = _tagStateKey.currentState?.getAllItem;
  if(lst!=null)
    lst.where((a) => a.active==true).forEach((a) => returnList.add(a.customData));
  return(returnList);
}
class ResList extends StatefulWidget {
  @override
  _ResListState createState() => _ResListState();
}

class _ResListState extends State<ResList> {

  List<Restaurant> res = List();
  List<Restaurant> resFiltered = List();
  List<String> filterKeyword = List();

  @override
  void initState() {
    super.initState();
  }

  void callback(List<String> filterKeyword) {
    setState(() {
      this.filterKeyword = filterKeyword;
    });
    resFiltered.clear();
    res.forEach((res) {
      if (compareString(res.type, this.filterKeyword)) {
        resFiltered.add(res);
      }
    });
  }

  bool compareString(String inputStr, List<String> items) {
    if (items.length == 0) {
      return true;
    }
    for(int i = 0; i < items.length; i++) {
      if(inputStr.contains(items[i])) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService().res,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          res = snapshot.data;
        }
        if (filterKeyword.isEmpty) {
          resFiltered = res;
        }
        return Column(
          children: <Widget>[
            Filter(this.callback),
            Expanded(
              child: ListView.builder(
                itemCount: resFiltered.length,
                itemBuilder: (BuildContext context, int index) {
                  return ResTile(res: resFiltered[index]);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class Filter extends StatefulWidget {
  final Function callback;
  Filter(this.callback);
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> with AutomaticKeepAliveClientMixin{
  // keep the widget alive when scroll out of view (saving filter)
  @override
  bool get wantKeepAlive => true;

  bool isExpand=false;
  void initState() {
    super.initState();
    isExpand = false;
    _items = _list.toList();
  }
  List _items;
  final List _list = [
    'Chinese',
    'Japanese',
    'American',
    'Italian',
    'Maxican',
    'Indian',
    'French',
    'Thai',
    'Korean',
    'Taiwanese',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: (isExpand==true)?const EdgeInsets.all(4.0):const EdgeInsets.all(4.0),
      child: Container(
        decoration:BoxDecoration(
            color: Colors.white,
            borderRadius: (isExpand!=true)?BorderRadius.all(Radius.circular(8)):BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Colors.pink)
        ),
        child: ExpansionTile(
          key: PageStorageKey<String>('PageStorageKey'),
          title: Container(
              width: double.infinity,
              child: Text((isExpand!=true)?'Food Type...':'Food Type',style: TextStyle(fontSize: (isExpand!=true)?18:18),),
          ),
          trailing: (isExpand==true)?Icon(Icons.arrow_drop_up,size: 32,color: Colors.pink,):Icon(Icons.arrow_drop_down,size: 32,color: Colors.pink),
          onExpansionChanged: (value){
            setState(() {
              isExpand=value;
            });
          },
          children: <Widget>[
            Tags(
              key: _tagStateKey,
              alignment: WrapAlignment.start,
              columns: 4,
              itemCount: _items.length, // required
              itemBuilder: (int index){
                final item = _items[index];
                return ItemTags(
                  onPressed: (item) {
                    this.widget.callback(_getAllItem());
                  },
                  key: Key(index.toString()),
                  index: index,
                  active: false,
                  color: Colors.black12,
                  activeColor: Colors.deepOrange,
                  title: item,
                  customData: item,
                  textStyle: TextStyle(fontSize: 12),
                  combine: ItemTagsCombine.withTextBefore,
                  icon: ItemTagsIcon(
                    icon: Icons.add_circle,
                  ) ?? '',
                );
              },
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }
}

class ResTile extends StatefulWidget {
  final Restaurant res;
  ResTile({this.res});

  @override
  _ResTileState createState() => _ResTileState();
}

class _ResTileState extends State<ResTile> {
  @override
  void initState() {
    widget.res.getAddress().then(updateLocation);
    super.initState();
  }
  String _location = 'Loading...';
  void updateLocation(String location) async {
    setState(() {
      this._location = location.split(',')[1];
    });
  }

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
              MaterialPageRoute(builder: (context) => ResPage(res: widget.res)),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('${widget.res.image}'),
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
                    '${widget.res.name}',
                    style: Theme.of(context).textTheme.headline,
                  ),
                ],
              ),
              Text('Like: ${widget.res.like}, Dislike: ${widget.res.dislike}'
                  '\nFood Type: ${widget.res.type}'
                  '\nPhone: ${widget.res.phone}'
                  '\nPrice: ${widget.res.price}'
                  '\nLocation: ' + _location +
                  '\nRestaurant ID: ${widget.res.restaurant_id}'),
              RaisedButton(
                  child: Text('location',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: new Color(0xff622f74),
                  onPressed:(){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>FireMap(res: widget.res,)),
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
