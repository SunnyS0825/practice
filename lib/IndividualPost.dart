import 'package:flutter/material.dart';
import 'Styles.dart';

class IndividualPost extends StatefulWidget {
  @override
  _IndividualPostState createState() => _IndividualPostState();
}

class _IndividualPostState extends State<IndividualPost>{
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
  int rows = 0;

  void _incrementFollowers() {
    setState(() {
      _follower++;
      if(_follower >= 1000000){
        String replace =  (_follower / 1000000).toStringAsFixed(1);
        _followers = '$replace' + 'm';
      }
      else if (_follower >= 1000){
        String replace = (_follower / 1000).toStringAsFixed(1);
        _followers =  '$replace' + 'k';
      }
      else{
        _followers = '$_follower';
      }
    });
  }

  Widget _buildAppBar(){
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.keyboard_return),
        color: Colors.white,
        onPressed: (){},
        iconSize: 20.0,
      ),
      backgroundColor: Colors.lightBlueAccent,
    );
  }

  Widget _buildProfileImage(){
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
                    _gender,
                    style: whiteTextStyleMedium,
                  ),
                ),
                Container(
                  height: 40.0,
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


  Widget _buildStatItem(String label, String count){
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: blackTextStyleMedium,
        ),
        Text(
          label,
          style: blackTextStyleBasic,
        ),
      ],
    );
  }

  Widget _buildList(){
    return ListView(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              width: (MediaQuery.of(context).size.width - 20) / 3,
              height: (MediaQuery.of(context).size.width - 20) / 3,
              margin: const EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                color: Colors.pink[50],
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width - 20) / 3,
              height: (MediaQuery.of(context).size.width - 20) / 3,
              margin: const EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                color: Colors.pink[100],
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width - 20) / 3,
              height: (MediaQuery.of(context).size.width - 20) / 3,
              margin: const EdgeInsets.only(left: 5.0, right: 5.0),
              decoration: BoxDecoration(
                color: Colors.pink[150],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatContainer(){
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:<Widget>[
          _buildStatItem("Followers", _followers),
          _buildStatItem("Follow", _follows),
          _buildStatItem("Likes", _likes),
          _buildStatItem("Views", _views),
        ],
      ),
    );
  }

  Widget _buildButtons(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: _incrementFollowers,
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Color(0xFF404A5C),
                ),
                child: Center(
                  child: Text(
                    "Follow",
                    style: whiteTextStyleMedium,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () => print('Text'),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Color(0xFF404A5C),
                ),
                child: Center(
                  child: Text(
                    "Text",
                    style: whiteTextStyleMedium,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewTab(){
    return DefaultTabController(
        length: 2,
        child: SizedBox(
            height: 800,
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
                      GridView.count(
                          padding: EdgeInsets.all(2.0),
                          crossAxisCount: 3,
                          children: Colors.primaries.map((color) {
                            return Container(color: color, height: 150);
                          }).toList()
                      ),
                      GridView.count(
                          padding: EdgeInsets.all(2.0),
                          crossAxisCount: 3,
                          children: Colors.primaries.map((color) {
                            return Container(color: color, height: 150);
                          }).toList()
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
            _buildButtons(),
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