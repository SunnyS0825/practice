import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CommunityPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CommunityPageState();
  }
}

class CommunityPageState extends State<CommunityPage>
    with AutomaticKeepAliveClientMixin<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);
    return RefreshIndicator(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _communityPageSliverAppBar(),
            _communityPageSliverGrid(),
          ],
        ),
      ),
      onRefresh: _onRefreshPulled,
    );
  }

  // overridden, keeps page status
  @override
  bool get wantKeepAlive => true;

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

  static List<String> _getPopupChoicesList() {
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

  /*
  * Shows AlertDialog with customized BuildContext, title, message, and exit
  * button text
  */
  Future<void> _showAlertDialog(String title, String message,
      String buttonText) async {
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
    // may be merged with me page block function
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

  Padding pBtn(IconData icon, Color color, Function onPressed, Alignment a) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Align(
            alignment: a,
            child: IconButton(
              icon: Icon(icon, color: color),
              onPressed: onPressed,
            )));
  }

  // stories
  List<Widget> sliverAppBarActions() {
    List l = new List<Widget>();
    l.add(pBtn(Icons.people, Colors.white, null, Alignment.topLeft));
    l.add(pBtn(Icons.favorite, Colors.white, null, Alignment.topLeft));
    l.add(pBtn(Icons.favorite_border, Colors.white, null, Alignment.topLeft));
    l.add(pBtn(Icons.image, Colors.white, null, Alignment.topLeft));
    l.add(pBtn(Icons.import_contacts, Colors.white, null, Alignment.topLeft));
    l.add(pBtn(Icons.school, Colors.white, null, Alignment.topLeft));
    l.add(pBtn(Icons.schedule, Colors.white, null, Alignment.topLeft));
    l.add(pBtn(Icons.add, Colors.white, null, Alignment.topLeft));
    l.add(pBtn(
        Icons.screen_lock_landscape, Colors.white, null, Alignment.topLeft));
    l.add(pBtn(Icons.airline_seat_legroom_extra, Colors.white, null,
        Alignment.topLeft));
    l.add(pBtn(Icons.people, Colors.white, null, Alignment.topLeft));
    l.add(pBtn(Icons.people, Colors.white, null, Alignment.topLeft));
    l.add(pBtn(Icons.people, Colors.white, null, Alignment.topLeft));
    l.add(pBtn(Icons.people, Colors.white, null, Alignment.topLeft));
    return l;
  }

  // sliverAppBar
  Widget _communityPageSliverAppBar() {
    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: false,
      actions: sliverAppBarActions(),
    );
  }

  // sliverGrid
  Widget _communityPageSliverGrid() {
    return SliverGrid.count(
      crossAxisCount: 2,
      children: sliverAppBarActions(),
    );
  }
}
