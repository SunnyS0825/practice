import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeprecatedCommunityPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DeprecatedCommunityPageState();
  }
}

class DeprecatedCommunityPageState extends State<DeprecatedCommunityPage>
    with AutomaticKeepAliveClientMixin<DeprecatedCommunityPage> {
  List<List<bool>> _isLikedList = getEmptyBoolsList();
  List<String> _areaList = getAreaList();
  String _disPlayedValue = getAreaList()[0];
  List<String> _usernameList = getUsernameList();
  List<String> _popupChoicesList = getPopupChoicesList();
  int _areaIndex = 0;
  List<int> _singleAreaPostsLen = [5, 4, 3, 2];

  /*
  * Clickable button with customized IconData, Color, Function, Alignment
  */
  Padding pBtn(IconData icon, Color color, Function onPressed, Alignment a) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Align(
            alignment: a,
            child: IconButton(
              icon: Icon(icon, color: color),
              onPressed: onPressed,
        ),
      ),
    );
  }

  /*
  * Builds area drop button
  */
  Widget areaDBtn(List<String> areaList) {
    return DropdownButton<String>(
      value: _disPlayedValue,
      icon: Icon(Icons.arrow_downward, color: Colors.white),
      iconSize: 24.0,
      elevation: 16,
      underline: Container(color: Colors.red),
      onChanged: (String newValue) {
        setState(
                () {
          _disPlayedValue = newValue;
          _areaIndex = areaList.indexOf(_disPlayedValue);
            }
        );
      },
      selectedItemBuilder: (BuildContext context) {
        return areaList.map((String value) {
          return Center(
              child: Text(
            _disPlayedValue,
            style: TextStyle(color: Colors.white),
              ),);
        }).toList();
      },
      items: areaList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  /*
  * Builds post
  */
  Widget post(BuildContext context, int index, Image image, bool isLikePressed,
      String username) {
    Color likeColor = isLikePressed ? Colors.red : Colors.black;
    IconData likeIconData =
        isLikePressed ? Icons.favorite : Icons.favorite_border;
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(children: <Widget>[
        Align(
            alignment: Alignment.topRight,
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.lightBlueAccent,
                  child: Text(username[0]),
                ),
                Text(
                  username,
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                Expanded(
                    flex: 60,
                    child: PopupMenuButton<String>(
                      onSelected: _onPostManagementSelected,
                      itemBuilder: (BuildContext context) {
                        return _popupChoicesList.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    )),
              ],
            )),
        SizedBox(width: MediaQuery.of(context).size.width, child: image),
        Align(
            alignment: Alignment.bottomRight,
            child: Row(children: <Widget>[
              Expanded(
                  flex: 15,
                  child: pBtn(Icons.send, Colors.black, () {
                    _showAlertDialog('Message sent',
                        'The message has been successfully sent to XXX.', 'OK');
                    setState(() {
                      // TODO: Implement message
                    });
                  }, Alignment.centerLeft)),
              pBtn(Icons.message, Colors.black, () {
                _showAlertDialog('Commented on Post',
                    'The comment has been successfully posted.', 'OK');
                setState(() {
                  // TODO: Implement comment
                });
              }, Alignment.centerRight),
              pBtn(Icons.share, Colors.black, () {
                _showAlertDialog('Post Shared',
                    'The post has been successfully shared to XXX.', 'OK');
                setState(() {
                  // TODO: Implement share
                });
              }, Alignment.centerRight),
              pBtn(likeIconData, likeColor, () {
                setState(() {
                  _isLikedList[_areaIndex][index] = !isLikePressed;
                  // TODO: update to database
                });
              }, Alignment.centerRight),
            ]))
      ]),
    );
  }

  /*
  * Shows AlertDialog with customized BuildContext, title, message, and exit
  * button text
  */
  Future<void> _showAlertDialog(
      String title, String message, String buttonText) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(buttonText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /*
  * method to be activated if refresh button is pulled
  */
  Future<Null> _onRefreshPulled() async {
    await new Future.delayed(new Duration(seconds: 1));

    setState(() {
      // TODO: Implement refresh
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin.build
    // sample posts

    return RefreshIndicator(
      child: Scaffold(
        appBar: AppBar(
          leading: pBtn(Icons.people, Colors.white, null, Alignment.topLeft),
          title: Text('Community', style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            pBtn(Icons.add, Colors.white, () {
              setState(() {
                _singleAreaPostsLen[_areaIndex] += 1;
                _showAlertDialog('Post added',
                    'The post has been successfully added.', 'OK');
              });
            }, Alignment.topRight),
            pBtn(Icons.location_on, Colors.white, null, Alignment.topLeft),
            Center(child: areaDBtn(_areaList)),
          ],
          backgroundColor: Colors.red,
        ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            _isLikedList[_areaIndex].add(false);
            Widget singlePost = post(
                context,
                index,
                Image(
                  image: AssetImage('android/app/src/main/res/people' +
                      (_areaIndex + 1).toString() +
                      '.jpg'),
                  fit: BoxFit.contain,
                ),
                _isLikedList[_areaIndex][index],
                _usernameList[index]);

            return singlePost;
          },
          itemCount: _singleAreaPostsLen[_areaIndex],
        ),
      ),
      onRefresh: _onRefreshPulled,
    );
  }

  // overridden, keeps page status
  @override
  bool get wantKeepAlive => true;

  // sample methods
  static List<String> getUsernameList() {
    List<String> list = new List<String>();
    list.add('Alpha');
    list.add('Beta');
    list.add('Gamma');
    list.add('Tau');
    list.add('Theta');

    return list;
  }

  static List<String> getAreaList() {
    List<String> list = new List<String>();
    list.add('DT');
    list.add('Markham');
    list.add('Guelph');
    list.add('North York');

    return list;
  }

  static List<List<bool>> getEmptyBoolsList() {
    List<List<bool>> isLikedList = new List();
    List list = getAreaList();
    for (int i = 0; i < list.length; i++) {
      isLikedList.add(new List<bool>());
    }
    return isLikedList;
  }

  static List<String> getPopupChoicesList() {
    List<String> list = new List<String>();
    list.add('Hide Post');
    list.add('Archive Post');
    list.add('Delete Post');
    list.add('Block User');
    list.add('Report');

    return list;
  }

  void _onPostManagementSelected(String choice) {
    switch (choice) {
      case 'Hide Post':
        _onHidePostSelected();
        break;
      case 'Archive Post':
        _onArchivePostSelected();
        break;
      case 'Delete Post':
        _onDeletePostSelected();
        break;
      case 'Block User':
        _onBlockUserSelected();
        break;
      case 'Report':
        _onReportSelected();
        break;
    }
  }

  // onSelected methods
  void _onHidePostSelected() {
    // TODO: Implement hide post
    setState(() {
      _showAlertDialog(
          'Post hidden', 'The post has been successfully hidden.', 'OK');
    });
  }

  void _onArchivePostSelected() {
    // TODO: Implement hide post
    setState(() {
      _showAlertDialog(
          'Post archived', 'The post has been successfully archived.', 'OK');
    });
  }

  void _onDeletePostSelected() {
    // TODO: Implement delete post
    setState(() {
      _showAlertDialog(
          'Post deleted', 'The post has been successfully deleted.', 'OK');
    });
  }

  void _onBlockUserSelected() {
    // TODO: Implement block user
    // may be merged with me mage block function
    setState(() {
      _showAlertDialog(
          'User blocked', 'The user has been successfully blocked.', 'OK');
    });
  }

  void _onReportSelected() {
    // TODO: Implement report
    setState(() {
      _showAlertDialog(
          'Post reported', 'The post has been successfully reported.', 'OK');
    });
  }
}
