import 'package:flutter/material.dart';
import 'Styles.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'MePage.dart';

class MyAccountPage extends StatefulWidget {
  MyAccountPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage>
{
  final String _fullName = 'Sunny Sun';
  final String _location = 'Toronto';
  final String _gender = 'Female';
  final String _awards = '25';
  int _follower = 999999;
  String _followers = '999.9k';
  int _follow = 0;
  String _follows = '500';
  int _like = 0;
  String _likes = '400';
  int _view = 0;
  String _views = '1.0k';
  int rows = 5;


  Widget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.keyboard_return),
        color: Colors.white,
        onPressed: () {return MePage();},
        iconSize: 20.0,
      ),
      backgroundColor: Colors.red,
    );
  }

  Widget _buildProfileImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            color: Colors.pinkAccent,
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: Text(
                _fullName,
                style: blackTextStyleTitle,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                      _location,
                      style: whiteTextStyleMedium
                  ),
                ),
                Container(
                  height: 30.0,
                  margin: const EdgeInsets.only(left: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    _gender,
                    style: whiteTextStyleMedium,
                  ),
                ),
                Container(
                  height: 30.0,
                  margin: const EdgeInsets.only(left: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'Awards: ' + _awards,
                    style: whiteTextStyleMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }


  Widget _buildStatItem(String label, String count) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: blackTextStyleMedium,
        ),
        Text(
          label,
          style: blackTextStyleBold,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Followers", _followers),
          _buildStatItem("Follow", _follows),
          _buildStatItem("Likes", _likes),
          _buildStatItem("Views", _views),
        ],
      ),
    );
  }



  Widget _buildNewTab() {
    return DefaultTabController(
        length: 2,
        child: SizedBox(
            height: double.maxFinite,
            child: Column(
              children: <Widget>[
                TabBar(
                  labelColor: Colors.black,
                  tabs: <Widget>[
                    Tab(
                      text: 'Posts',
                    ),
                    Tab(
                      text: 'Likes',
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: 8,
                        itemBuilder: (BuildContext context, int index) =>
                        new Container(
                          color: Colors.greenAccent,
                        ),
                        staggeredTileBuilder: (int index) =>
                        new StaggeredTile.count(2, index.isEven ? 2:1),
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                      ),
                      StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        itemCount: 8,
                        itemBuilder: (BuildContext context, int index) =>
                        new Container(
                          color: Colors.redAccent,
                        ),
                        staggeredTileBuilder: (int index) =>
                        new StaggeredTile.count(2, index.isEven ? 2:1),
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                      ),
                    ],
                  ),
                ),
              ],
            )
        )
    );
  }

  @override
  Widget build(BuildContext context){
    //  Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body://Container(
      //  children: <Widget>[
      //  child: SafeArea(
      // child:
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildAppBar(),
            _buildProfileImage(),
            _buildStatContainer(),
            SizedBox(height: 8.0),
            _buildNewTab(),
            // _buildInfo(),
          ],
        ),
        //),
      ),
      //],
      // ),
    );
  }
}