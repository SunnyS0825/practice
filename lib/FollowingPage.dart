import 'package:flutter/material.dart';
import 'Styles.dart';
import 'package:faker/faker.dart';

class FollowingPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return FollowingPageState();
  }
}

class FollowingPageState extends State<FollowingPage> {

  List<Widget> followingList = List<Widget>();
  var storyList = List();
  var _followingRisingPadding = List<EdgeInsets>();//EdgeInsets.only(bottom: 10, right: 10);
  var _followingFadeOutOpacity = List<double>();//1.0;
  var _followingLiked = List<bool>();
  var _followingIsAnimating = List<bool>();//false;

  var selfieURL = 'https://magazine.utoronto.ca/wp-content/uploads/2016/08/Selfie_480-1200x630-c-default.jpg';

  _startFollowingHeart(int i) {

    setState((){
      _followingIsAnimating[i] = true;
      //try to force it to reload from the FollowingPage() level (eg. it refreshes if you swipe to third page and then back)
    });
  }

  _animateFollowingHeart(int i) {

    print("rise");
    setState(() {
      _followingRisingPadding[i] = EdgeInsets.only(bottom: 100, right: 10);
      _followingFadeOutOpacity[i] = 0.0;
    });
  }

  _resetFollowingHeart(int i) {

    setState(() {
      _followingRisingPadding[i] = EdgeInsets.only(bottom: 10, right: 10);
      _followingFadeOutOpacity[i] = 1.0;
      _followingIsAnimating[i] = false;
    });
  }

  void _buildStoryList() {

    for (var i = 1; i <= 5; i++) {
      storyList.add(Column(children: <Widget>[
        Padding(
            padding: EdgeInsets.all(5),
            child: Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                    radius: 25,
                    backgroundImage: Image.network(
                        selfieURL,
                        fit: BoxFit.cover)
                        .image))),
        Expanded(
            child: Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: Text(
                  'username',
                  style: blackTextStyleBasic,
                )))
      ]));
    }
  }

  void _buildFollowingList() {

    followingList.clear();
    for (var i = 1; i <= 10; i++) {

      if (_followingLiked.length < i) {
        _followingLiked.add(false);
        _followingIsAnimating.add(false);
        _followingRisingPadding.add(EdgeInsets.only(bottom: 10.0, right: 10.0));
        _followingFadeOutOpacity.add(1.0);
      }

      followingList.add(Stack(children: <Widget>[

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
                      _startFollowingHeart(i - 1);
                      _followingLiked[i - 1] = true;
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
                            if (_followingLiked[i - 1]) {

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
            visible: _followingIsAnimating[i - 1],
            child: Positioned.fill(child: Align(
                alignment: Alignment.bottomRight,
                child: AnimatedPadding(
                    padding: _followingRisingPadding[i - 1],
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOut,
                    child: () {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        //opacity: 1, animating: false -> 1, true *->* 0, true
                        if (_followingFadeOutOpacity[i - 1] == 1 && _followingIsAnimating[i - 1]) {
                          _animateFollowingHeart(i - 1); print("after?");
                        }
                      });

                      return AnimatedOpacity(
                          opacity: () {print('257 ${_followingIsAnimating[i-1]} ${_followingFadeOutOpacity[i-1]}'); return _followingFadeOutOpacity[i - 1];}(),
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

    _buildStoryList();
    _buildFollowingList();

    return Column(children: <Widget>[
      SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, position) {

              return storyList[position];
            },
            itemCount: storyList.length,
          )
      ),
      GridView.count(
          crossAxisCount: 2,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          semanticChildCount: followingList.length,
          childAspectRatio: 0.60,
          children: followingList,


          /*itemBuilder: (c, pos) {

            return followingList[pos];
          },
          itemCount: followingList.length,*/
      )
    ]);
  }
}