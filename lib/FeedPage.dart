import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Styles.dart';
import 'dart:ui';
import 'package:animator/animator.dart';
import 'FollowingPage.dart';
import 'ExplorePage.dart';
import 'NearbyPage.dart';

class FeedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FeedPageState();
  }
}

class FeedPageState extends State<FeedPage> {

  var selfieURL = 'https://magazine.utoronto.ca/wp-content/uploads/2016/08/Selfie_480-1200x630-c-default.jpg';

  int _currentIndex = 0;
  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  double _rightPos = 0;
  double _leftPos = 0;

  RenderBox selectorBox;
  Offset selectorPos;

  bool pageChanging = true;
  bool init = true;

  void hideTopBar() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  GlobalKey followingKey = GlobalKey();
  GlobalKey exploreKey = GlobalKey();
  GlobalKey nearbyKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    WidgetsBinding.instance.addPostFrameCallback((_) {

      if (pageChanging) {

        _setSelector();
      }
    });

    // TODO: implement build
    return ListView(
      primary: true,
      children: <Widget>[
        Container(
            child: Row(
              children: <Widget>[

                Padding(padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    )),
                Expanded(
                    flex: 10,
                    child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Align(alignment: Alignment.center, child: Text(
                            'Community',
                            style: whiteTextStyleBasic
                        ))
                    )
                ),
                Padding(padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.message,
                      color: Colors.white,
                    )),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.red,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 10,
                    blurRadius: 10,
                  )
                ]
            )
        ),
        Container(
            height: 10,
            decoration: BoxDecoration(
              color: Colors.red,
              gradient: new LinearGradient(
                colors: [Colors.black26, Colors.red],
                begin: Alignment(0.5, -18.0),
                end: Alignment(0.5, 1.0),
              ),
            )
        ),
        Container(
          color: Colors.red,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Padding(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 4),
                      child: FlatButton(
                          child: Text(
                            'Follow',
                            key: followingKey,
                            style: whiteTextStyleBasic,
                          ),
                          onPressed: () {

                            setState((){

                              _currentIndex = 0;
                            });
                            _pageController.jumpToPage(0);
                            pageChanging = true;
                          },
                      )
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 4),
                      child: FlatButton(
                        child: Text(
                          'Explore',
                          key: exploreKey,
                          style: whiteTextStyleBasic,
                        ),
                        onPressed: () {

                          setState((){

                            _currentIndex = 1;
                          });
                          _pageController.jumpToPage(1);
                          pageChanging = true;
                        },
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 12, 12, 4),
                      child: FlatButton(
                        child: Text(
                          'Nearby',
                          key: nearbyKey,
                          style: whiteTextStyleBasic,
                        ),
                        onPressed: () {

                          setState((){

                            _currentIndex = 2;
                          });
                          _pageController.jumpToPage(2);
                          pageChanging = true;
                        },
                      )
                  )
                ],
              ),
              AnimatedPadding(
                padding:
                () {
                  print('148 leftPos: ${_leftPos.toString()}, rightPad + ${MediaQuery.of(context).size.width.toDouble() - _rightPos}');
                  return EdgeInsets.only(left: _leftPos, right: MediaQuery.of(context).size.width.toDouble() - _rightPos);
                } (),
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: Divider(
                  color: Colors.white,
                  height: 3,
                  thickness: 3,
                ),
              ),
              Align(alignment: Alignment.center,
                  child: Padding(padding: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10), child: Container(color: Colors.white,
                      height: 30,
                      child: TextField(
                        onEditingComplete: hideTopBar,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: blackTextStyleBasic,
                          isDense: true,
                          contentPadding: EdgeInsets.only(top: 5.0),
                          alignLabelWithHint: true,
                        ),
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                      )))
              ),
            ],
          ),
        ),
        SizedBox(
            height: double.maxFinite,
            child: PageView.builder(
              itemCount: 3,
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {

                switch (index) {
                  case 0:
                    selectorBox = followingKey.currentContext.findRenderObject();
                    print('185 ' + selectorBox.globalToLocal(Offset.zero).toString());
                    selectorPos = selectorBox.globalToLocal(Offset.zero);
                    print('187 ' + selectorPos.dx.toString());
                    return FollowingPage();
                  case 1:
                    selectorBox = exploreKey.currentContext.findRenderObject();
                    selectorPos = selectorBox.localToGlobal(Offset.zero);
                    return ExplorePage();
                  case 2:
                    selectorBox = nearbyKey.currentContext.findRenderObject();
                    selectorPos = selectorBox.localToGlobal(Offset.zero);
                    return NearbyPage();
                }

                return Container();
              },
              onPageChanged: (index) {
                print("175 changed");
                setState(() {
                  _currentIndex = index;
                });
                pageChanging = true;
              },
            )
        )
      ],
    );
  }

  void _setSelector() {

    RenderBox _selectorBox;
    Offset _selectorPos;

    print('233 $_currentIndex');

    switch (_currentIndex) {
      case 0:
        _selectorBox = followingKey.currentContext.findRenderObject();
        print('185 ' + _selectorBox.globalToLocal(Offset.zero).toString());
        _selectorPos = _selectorBox.globalToLocal(Offset.zero);
        print('187 ' + _selectorPos.dx.toString());
        break;
      case 1:
        _selectorBox = exploreKey.currentContext.findRenderObject();
        print('185 ' + _selectorBox.globalToLocal(Offset.zero).toString());
        _selectorPos = _selectorBox.localToGlobal(Offset.zero);
        print('187 ' + _selectorPos.dx.toString());
        break;
      case 2:
        _selectorBox = nearbyKey.currentContext.findRenderObject();
        print('185 ' + _selectorBox.globalToLocal(Offset.zero).toString());
        _selectorPos = _selectorBox.localToGlobal(Offset.zero);
        print('187 ' + _selectorPos.dx.toString());
        break;
    }

    setState(() {
      _selectorPos.dx < 0 ? _leftPos = -_selectorPos.dx : _leftPos = _selectorPos.dx;
      _rightPos = _leftPos + _selectorBox.size.width;

      print('204 $_leftPos $_rightPos');
      pageChanging = false;
    });
  }
}
