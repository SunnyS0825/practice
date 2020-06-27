import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeprecatedHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DeprecatedHomePageState();
  }
}

class _DeprecatedHomePageState extends State<DeprecatedHomePage> {
  var feedList = List();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    for (var i = 1; i <= 10; i++) {
      feedList.add(Image(
        image: AssetImage(
            'android/app/src/main/res/restaurant' + i.toString() + '.jpeg'),
        fit: BoxFit.contain,
      ));
    }

    void hideTopBar() {

      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    }

    // TODO: implement build
    return Column(children: <Widget>[
      Container(
          color: Colors.red,
          child: Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 6, right: 6),
                child: Icon(
                  Icons.location_on,
                  color: Colors.white,
              )),
              Padding(padding: EdgeInsets.only(left: 6),
                child: Text('Area',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.white,
                ))),
              Expanded(
                  flex: 5,
                  child: Padding(padding: EdgeInsets.only(left: 12),
                    child: TextField(
                        onEditingComplete: hideTopBar,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '... Search',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.white,
                            )
                      )))),
              Padding(padding: EdgeInsets.only(left: 12),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
              )),
              Padding(padding: EdgeInsets.only(left: 12, right: 12),
                child: Text('Scan',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.white,
                ))
              )
            ],
          )),
      SizedBox(height: 6),
      Container(color: Colors.red, child: Padding(
        padding: EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 6.0),
        child: Text('Hot News',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
        )))),
      SizedBox(height: 6),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
        Container(color: Colors.red, child: Padding(
          padding: EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 6.0),
            child: Text('Hot Resaurant',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              )
            )
        )),
        Container(color: Colors.red, child: Padding(
          padding: EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 6.0),
          child: Text('Pick For You',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
        )))),
        Container(color: Colors.red, child: Padding(
            padding: EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 6.0),
            child: Text('Style',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
        )))),
        Container(color: Colors.red, child: Padding(
          padding: EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 6.0),
          child: Text('Nearby',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
        ))))
      ]),
      SizedBox(height: 6),
       Expanded(flex:10, child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, position) {
          return Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(children: <Widget>[
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: feedList[position]),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Row(children: <Widget>[
                    Expanded(
                        flex: 15,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.send,
                                  color: Colors.black,
                                )))),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Icon(
                          Icons.message,
                          color: Colors.black,
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Icon(
                          Icons.share,
                          color: Colors.black,
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                        ))
                  ]))
            ]),
          );
        },
        itemCount: feedList.length,
      ))
    ]);
  }
}