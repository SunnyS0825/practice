import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Styles.dart';

class NearbyPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NearbyPageState();
  }
}

class NearbyPageState extends State<NearbyPage> {

  List<Widget> nearbyList = List<Widget>();
  var _nearbyRisingPadding = List<EdgeInsets>();//EdgeInsets.only(bottom: 10, right: 10);
  var _nearbyFadeOutOpacity = List<double>();//1.0;
  var _nearbyLiked = List<bool>();
  var _nearbyIsAnimating = List<bool>();//false;

  var selfieURL = 'https://magazine.utoronto.ca/wp-content/uploads/2016/08/Selfie_480-1200x630-c-default.jpg';

  _startNearbyHeart(int i) {

    setState((){
      _nearbyIsAnimating[i] = true;
    });
  }

  _animateNearbyHeart(int i) {

    print("rise");
    setState(() {
      _nearbyRisingPadding[i] = EdgeInsets.only(bottom: 100, right: 10);
      _nearbyFadeOutOpacity[i] = 0.0;
    });
  }

  _resetNearbyHeart(int i) {

    setState(() {
      _nearbyRisingPadding[i] = EdgeInsets.only(bottom: 10, right: 10);
      _nearbyFadeOutOpacity[i] = 1.0;
      _nearbyIsAnimating[i] = false;
    });
  }

  void _buildNearbyList() {

    nearbyList.clear();
    for (var i = 1; i <= 10; i++) {

      if (_nearbyLiked.length < i) {
        _nearbyLiked.add(false);
        _nearbyIsAnimating.add(false);
        _nearbyRisingPadding.add(EdgeInsets.only(bottom: 10.0, right: 10.0));
        _nearbyFadeOutOpacity.add(1.0);
      }

      nearbyList.add(Stack(children: <Widget>[

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
                      _startNearbyHeart(i - 1);
                      _nearbyLiked[i - 1] = true;
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
                            if (_nearbyLiked[i - 1]) {

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
            visible: _nearbyIsAnimating[i - 1],
            child: Positioned.fill(child: Align(
                alignment:
                Alignment.bottomRight,
                child: AnimatedPadding(
                    padding: _nearbyRisingPadding[i - 1],
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOut,
                    child: () {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

                        if (_nearbyFadeOutOpacity[i - 1] == 1 && _nearbyIsAnimating[i - 1]) {
                          _animateNearbyHeart(i - 1); print("after?");
                        }
                      });

                      return AnimatedOpacity(
                          opacity: _nearbyFadeOutOpacity[i - 1],
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
  Widget build(BuildContext buildContext) {

    _buildNearbyList();

    return Column(children: <Widget>[
      GridView.count(
          crossAxisCount: 2,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          semanticChildCount: nearbyList.length,
          childAspectRatio: 0.60,
          children: nearbyList
      )
    ]);
  }
}