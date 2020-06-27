import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                primary: true,

                forceElevated: false,

                automaticallyImplyLeading: true,

                expandedHeight: 200.0,

                snap: true,
                floating: false,
                title: _title(),
                pinned: false,
                leading: Icon(Icons.menu),
                flexibleSpace:
                FlexibleSpaceBar(
                  centerTitle: true,
                  title: _title(),
                  background: Image.network(
                    'https://images.pexels.com/photos/443356/pexels-photo-443356.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ];
          },
          body: Center(
              child: SliverList(
                delegate: new SliverChildListDelegate(_buildList()),
              )
          ),
        ));
  }

  _title() {
    return Text("Me",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ));
  }

  List _buildList() {
    List<Widget> listItems = List();

    listItems.add(new Padding(padding: new EdgeInsets.all(20.0),
        child: new Text('Profile',
          style: new TextStyle(fontSize: 25.0),
        )
    ));

    listItems.add(new Padding(padding: new EdgeInsets.all(20.0),
        child: new Text('Collection',
          style: new TextStyle(fontSize: 25.0),
        )
    ));

    listItems.add(new Padding(padding: new EdgeInsets.all(20.0),
        child: new Text('Recently Viewed',
          style: new TextStyle(fontSize: 25.0),
        )
    ));

    listItems.add(new Padding(padding: new EdgeInsets.all(20.0),
        child: new Text('Report',
          style: new TextStyle(fontSize: 25.0),
        )
    ));

    listItems.add(new Padding(padding: new EdgeInsets.all(20.0),
        child: new Text('Support',
          style: new TextStyle(fontSize: 25.0),
        )
    ));

    listItems.add(new Padding(padding: new EdgeInsets.all(70.0),
        child: new Text('',
          style: new TextStyle(fontSize: 25.0),
        )
    ));

    return listItems;
  }
}