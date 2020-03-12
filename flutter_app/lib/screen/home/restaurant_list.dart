import 'package:flutter/material.dart';
import 'package:flutter_app/models/restaurant.dart';
import 'package:flutter_app/screen/home/restaurant_page/restaurant_reviews.dart';
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
        return SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: <Widget>[
                Filter(this.callback),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: resFiltered.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ResTile(res: resFiltered[index]);
                  },
                ),
            ],
          ),
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
      padding: (isExpand==true)?const EdgeInsets.fromLTRB(2, 2, 2, 0):const EdgeInsets.fromLTRB(2, 2, 2, 0),
      child: Container(
        decoration:BoxDecoration(
            color: Colors.white,
            borderRadius: (isExpand!=true)?BorderRadius.all(Radius.circular(2)):BorderRadius.all(Radius.circular(2)),
            border: Border.all(color: Colors.pink)
        ),
        child: ExpansionTile(
          key: PageStorageKey<String>('PageStorageKey'),
          title: Container(
              width: double.infinity,
              child: Text((isExpand!=true)?'Food Type...':'Food Type',style: TextStyle(fontSize: (isExpand!=true)?18:18),),
          ),
          leading: Icon(Icons.fastfood),
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
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  title: item,
                  customData: item,
                  textStyle: TextStyle(fontSize: 14),
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
  String fullAddress = '';
  void updateLocation(String location) async {
    setState(() {
      this._location = location.split(',')[1];
      this.fullAddress = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4, 0, 4, 4),
      child: Material(
        color: Colors.white,
        child: InkWell(
          splashColor: Colors.deepOrange,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReviewList(res: widget.res, address: fullAddress)),
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
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${widget.res.name}',
                    style: Theme.of(context).textTheme.headline,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on, color: Colors.deepOrange,),
                            Text(_location),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.attach_money, color: Colors.deepOrange,),
                            Text(' ${widget.res.price}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.thumb_up, color: Colors.blueAccent,),
                            Text(' ${widget.res.like}'),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.thumb_down, color: Colors.redAccent,),
                            Text(' ${widget.res.dislike}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
