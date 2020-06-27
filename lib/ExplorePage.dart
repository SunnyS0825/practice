import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Styles.dart';

class ExplorePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExplorePageState();
  }
}

class ExplorePageState extends State<ExplorePage> {

  List<Widget> exploreList = List<Widget>();
  var _exploreRisingPadding = List<EdgeInsets>();//EdgeInsets.only(bottom: 10, right: 10);
  var _exploreFadeOutOpacity = List<double>();//1.0;
  var _exploreLiked = List<bool>();
  var _exploreIsAnimating = List<bool>();

  var selfieURL = 'https://magazine.utoronto.ca/wp-content/uploads/2016/08/Selfie_480-1200x630-c-default.jpg';

  _startExploreHeart(int i) {

    setState((){
      _exploreIsAnimating[i] = true;
    });
  }

  _animateExploreHeart(int i) {

    print("rise");
    setState(() {
      _exploreRisingPadding[i] = EdgeInsets.only(bottom: 100, right: 10);
      _exploreFadeOutOpacity[i] = 0.0;
    });
  }

  _resetExploreHeart(int i) {

    setState(() {
      _exploreRisingPadding[i] = EdgeInsets.only(bottom: 10, right: 10);
      _exploreFadeOutOpacity[i] = 1.0;
      _exploreIsAnimating[i] = false;
    });
  }

  void _buildExploreList() {

    exploreList.clear();
    for (var i = 1; i <= 10; i++) {

      if (_exploreLiked.length < i) {
        _exploreLiked.add(false);
        _exploreIsAnimating.add(false);
        _exploreRisingPadding.add(EdgeInsets.only(bottom: 10.0, right: 10.0));
        _exploreFadeOutOpacity.add(1.0);
      }

      exploreList.add(Stack(children: <Widget>[

        Container(
            decoration: BoxDecoration(
                border: () {

                  if (i % 2 == 1) {
                    return Border(
                        right: BorderSide(
                            color: Colors.black12,
                            width: 0.5
                        )
                    );
                  }
                  else {
                    return Border(
                        left: BorderSide(
                            color: Colors.black12,
                            width: 0.5
                        )
                    );
                  }
                }()
            ),
            child: Column(children: <Widget>[
              const Divider(
                color: Colors.black12,
                height: 1,
                thickness: 1,
              ),
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                          radius: 15,
                          backgroundImage: Image
                              .network(
                              selfieURL,
                              fit: BoxFit.cover)
                              .image)
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(5),
                    child: Text('username', style: blackTextStyleBasic))
              ]),
              SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: GestureDetector(
                    child: AspectRatio(aspectRatio: 1,
                        child: Container(decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                alignment: FractionalOffset.topCenter,
                                image: new AssetImage('assets/restaurant' + i.toString() + '.jpg')
                            )
                        ))
                    ),
                    onDoubleTap: () {
                      print("doubled");
                      _startExploreHeart(i - 1);
                      _exploreLiked[i - 1] = true;
                    },
                  )),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Row(children: <Widget>[
                    Expanded(
                        flex: 15,
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.send,
                                  color: Colors.black,
                                )))),
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.message,
                          color: Colors.black,
                        )),
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.share,
                          color: Colors.black,
                        )),
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                              () {
                            if (_exploreLiked[i - 1]) {

                              return Icons.favorite;
                            }

                            else {

                              return Icons.favorite_border;
                            }
                          }(),
                          color: Colors.red,
                        ))
                  ])),
              Padding(padding: EdgeInsets.all(5), child: Align(alignment: Alignment.topLeft, child: Text(
                  "caption text",
                  style: blackTextStyleBasic
              )))
            ]
            )
        ),
        Visibility(
            visible: _exploreIsAnimating[i - 1],
            child: Positioned.fill(child: Align(
                alignment:
                Alignment.bottomRight,
                child: AnimatedPadding(
                    padding: _exploreRisingPadding[i - 1],
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOut,
                    child: () {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

                        if (_exploreFadeOutOpacity[i - 1] == 1 && _exploreIsAnimating[i - 1]) {
                          _animateExploreHeart(i - 1); print("after?");
                        }
                      });

                      return AnimatedOpacity(
                          opacity: _exploreFadeOutOpacity[i - 1],
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeOut,
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                      );
                    }()
                )
            )
            )
        ),
      ]));
    }
  }

  @override
  Widget build(BuildContext context) {

    _buildExploreList();

    return Column(children: <Widget>[
      GridView.count(
          crossAxisCount: 2,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          semanticChildCount: exploreList.length,
          childAspectRatio: 0.60,
          children: exploreList
      )
    ]);
  }
}