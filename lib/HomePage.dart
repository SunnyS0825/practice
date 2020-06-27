import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lanstomach/HomePageProvider.dart';
import 'package:lanstomach/Styles.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  // TextEditingController for search text field
  final TextEditingController textController = TextEditingController();

  /*
  * Overridden dispose method, to add dispose of textController
  */
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

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
  * Overridden method, to build HomePage Widget
  * */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
        create: (context) => HomePageProvider(),
        child: Consumer<HomePageProvider>(
          builder: (context, provider, child) {
            return buildPage(provider);
          },
        ),
    );
  }

  /*
  * Builds the actual page for HomePage
  */
  RefreshIndicator buildPage(HomePageProvider provider) {
    return RefreshIndicator(
      child: CustomScrollView(
        slivers: pageSlivers(provider),
      ),
      onRefresh: provider.onRefreshPulled, // from HomePageProvider
    );
  }

  /*
  * Builds the slivers of CustomScrollView of HomePage
  */
  List<Widget> pageSlivers(HomePageProvider provider) {
    return <Widget>[
      _sliverAppBar(provider),
      _adAndCommentsSliverList(provider), // horizontal-scrolled
      _optionsSliverGrid(provider),
      _restaurantsSliverList(provider),
    ];
  }

  /*
  * Builds sliverAppBar of HomePage
  */
  SliverAppBar _sliverAppBar(HomePageProvider provider) {
    return SliverAppBar(
      leading: searchHeaderText(),
      title: searchTextField(),
      actions: sliverAppBarActions(provider),
    );
  }

  /*
  * Builds actions of sliverAppBar
  */
  List<Widget> sliverAppBarActions(HomePageProvider provider) {
    return <Widget>[
      // search button
      pBtn(Icons.search, Colors.white, () {
        onSearchPressed(provider);
      }, Alignment.topRight),
    ]; // actions
  }

  /*
  * Builds aligned text for header of sliverAppBar
  */
  Align searchHeaderText() {
    return Align(
        alignment: Alignment.centerRight,
        child: Text('Search',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'Roboto'
            ),
        ),
    );
  }

  /*
  * Builds TextField
  */
  TextField searchTextField() {
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Search for restaurants',
        hintStyle: whiteTextStyleBasic,
      ),
      controller: textController,
      style: whiteTextStyleBasic,
    );
  }

  /*
  * method to be activated on pressing search button
  */
  void onSearchPressed(HomePageProvider provider) {
    setState(() {
      String text = textController.text;
      provider.textToSearch = text; // update to HomePageProvider
      // test
      provider.showAlertDialog(context, 'Search Completed',
          'Your search for $text is successfully completed.', 'OK');
    });
  }

  /*
  * Builds ads and comments list by SliverToBoxAdapter
  */
  SliverToBoxAdapter _adAndCommentsSliverList(HomePageProvider provider) {
    List adsAndCommentsList = provider.getAdsAndCommentsList();
    return SliverToBoxAdapter(
      child: Container(
        height: 80,
        child: adsAndCommentsListViewBuilder(adsAndCommentsList),
      ),
    );
  }

  /*
  * Builds ads and comments ListView
  */
  ListView adsAndCommentsListViewBuilder(List adsAndCommentsList) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return (index % 2 == 1)
            ? circleAvatarAndName(adsAndCommentsList, index)
            : Container(width: 5); // even indices dividers
      },
      itemCount: adsAndCommentsList.length * 2 + 1, // plus dividers
    );
  }

  /*
  * Builds circleAvatar with first letter inside and name on bottom
  */
  Column circleAvatarAndName(List adsAndCommentsList, int index) {
    return Column(
      children: <Widget>[
        Container(height: 10), // divider
        circleAvatarWithStartingLetter(adsAndCommentsList, index),
        Container(height: 5), // divider
        Text(
          adsAndCommentsList[(index - 1) ~/ 2], // name
          style: TextStyle(color: Colors.black, fontFamily: 'Roboto'),
        ),
      ],
    );
  }

  /*
  * Builds circleAvatar with first letter inside
  */
  CircleAvatar circleAvatarWithStartingLetter(
      List adsAndCommentsList, int index) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.lightBlueAccent,
      child: Text(
        adsAndCommentsList[(index - 1) ~/ 2][0], // first letter of name
        style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
      ),
    );
  }

  /*
  * Builds options in HomePage by SliverGrid
  */
  SliverGrid _optionsSliverGrid(HomePageProvider provider) {
    return SliverGrid(
      gridDelegate: optionsSliverGridDelegate(),
      delegate: optionsSliverGridChildBuilderDelegate(),
    );
  }

  /*
  * Builds delegate of SliverGrid by SliverChildBuilderDelegate
  */
  SliverChildBuilderDelegate optionsSliverGridChildBuilderDelegate() {
    return SliverChildBuilderDelegate(
          (BuildContext context, int index) {
        return optionGrid(index); // options
      },
      childCount: 4,
    );
  }

  /*
  * Builds single option grid (template, uncompleted)
  */
  Container optionGrid(int index) {
    return Container(
      alignment: Alignment.center,
      color: Colors.teal[100 * (index % 9)],
      child: Text('grid item $index', style: blackTextStyleBasic),
    );
  }

  /*
  * Builds grid delegate of SliverGrid by
  * SliverGridDelegateWithFixedCrossAxisCount
  */
  SliverGridDelegateWithFixedCrossAxisCount optionsSliverGridDelegate() {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      childAspectRatio: 0.75,
    );
  }

  /*
  * Builds restaurants list by SliverToBoxAdapter
  */
  SliverToBoxAdapter _restaurantsSliverList(HomePageProvider provider) {
    List restaurantsList = provider.getRestaurantsList();
    return SliverToBoxAdapter(
      child: Container(
        height: 350,
        child: restaurantsListViewBuilder(restaurantsList),
      ),
    );
  }

  /*
  * Builds restaurants ListView
  */
  ListView restaurantsListViewBuilder(List restaurantsList) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return (index % 2 == 0)
            ? restaurantsList[index ~/ 2]
            : Divider(thickness: 3); // odd indices dividers
      },
      itemCount: restaurantsList.length * 2, // plus dividers
    );
  }
}
