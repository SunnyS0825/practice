import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'CommunityPage.dart';
import 'HangoutPage.dart';
import 'MePage.dart';
import 'HomePage.dart';
import 'RestaurantPage.dart';
import 'FeedPage.dart';
import 'MessagePage.dart';
import 'Styles.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'MyAlphabetListScrollView.dart';
import 'package:faker/faker.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
        title: 'LAN Stomach',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: MyPage()
    );
  }
}

class MyPage extends StatefulWidget {
  MyPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int _currentIndex = 0;

  static var rng = new Random();
  var selfieURL = 'https://magazine.utoronto.ca/wp-content/uploads/2016/08/Selfie_480-1200x630-c-default.jpg';
  List<String> names = new List<String>.generate(40, (i) => faker.person.firstName().toLowerCase() + faker.person.lastName().toLowerCase() + rng.nextInt(100).toString());

  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  List<BottomNavigationBarItem> _getBottomNavItems() {
    List<BottomNavigationBarItem> items = List();

    items.add(
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')));
    items.add(
        BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Me')));
    items.add(
        BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('Message')));
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Friends',
              style: whiteTextStyleBasic,
            ),
            Container(
                width: 120,
                height: MediaQuery.of(context).size.height * 0.80,
                color: Colors.white,
                child:

                MyAlphabetListScrollView(

                  showPreview: true,
                  strList: names,
                  indexedHeight: (i) {

                    return 100;
                  },
                  normalTextStyle: greyTextStyleBasic,
                  highlightTextStyle: blackTextStyleBasic,
                  itemBuilder: (context, i) {

                    return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 25, 5),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: Image.network(
                                          selfieURL,
                                          fit: BoxFit.cover)
                                          .image))),
                          Align(
                              alignment: Alignment.center,
                                  child: Padding(
                                      padding: EdgeInsets.fromLTRB(10, 5, 25, 10),
                                      child: Text(
                                        names[i],
                                        overflow: TextOverflow.ellipsis,
                                        style: blackTextStyleBasic,
                                      )))
                        ]
                    );
                  },
                )
            ),
          ],
        ),
        body: Stack(children: <Widget>[
          PageView.builder(
            itemCount: _getBottomNavItems().length,
            controller: _pageController,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return FeedPage();
                case 1:
                  return MePage();
                case 2:
                  return MessagePage();
              }
            },
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          /*Align(
        alignment: Alignment.topCenter,
        child: Padding(
            padding: EdgeInsets.only(top: 0.0),
            child: Container(
                color: Colors.red,
                child: Row(
                  children: <Widget>[
                    //SizedBox(width: MediaQuery.of(context).size.width / 3, ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: Text('My Feed',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          )),
                    )),
                  ],
                ))),
      ),*/
          Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavigationBar(
                  type: BottomNavigationBarType.shifting,
                  items: _getBottomNavItems(),
                  onTap: (clickedIndex) {
                    setState(() {
                      _currentIndex = clickedIndex;
                      _pageController.animateToPage(_currentIndex,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    });
                  },
                  currentIndex: _currentIndex,
                  unselectedItemColor: Colors.black12,
                  selectedItemColor: Colors.red))
        ]));
  }
}