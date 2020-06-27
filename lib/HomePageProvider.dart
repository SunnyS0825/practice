import 'package:flutter/material.dart';
import 'package:lanstomach/Styles.dart';

class HomePageProvider extends ChangeNotifier {
  // text to be searched that passed from HomePage search button
  String textToSearch = '';

  // testing value
  int testShift = 0;

  /*
  * method to be activated if refresh button is pulled
  */
  Future<Null> onRefreshPulled() async {
    await new Future.delayed(new Duration(seconds: 1));

    // shift alphabet of ads and comments list by 1
    // eg. [0] A -> B
    testShift += 1;
    notifyListeners();

    return null;
  }

  /*
  * Returns ads and comments list
  */
  List getAdsAndCommentsList() {
    List l = new List();
    for (int i = 0; i < 15; i++) {
      l.add(String.fromCharCode(i + 65 + testShift) * 4);
    }
    return l;
  }

  /*
  * Returns restaurants list
  */
  List getRestaurantsList() {
    List l = new List();
    l.add(restaurant(
        Icons.fastfood,
        'Restarant A',
        0.0,
        10.54,
        ['Hotpot', 'All-you-can-eat'],
        TimeOfDay(hour: 10, minute: 30),
        TimeOfDay(hour: 22, minute: 30)));
    l.add(restaurant(
        Icons.fastfood,
        'Restarant B',
        0.5,
        40.36,
        ['Sushi', 'All-you-can-eat'],
        TimeOfDay(hour: 10, minute: 30),
        TimeOfDay(hour: 22, minute: 30)));
    l.add(restaurant(Icons.fastfood, 'Restarant C', 1.0, 40.36, ['Chinese'],
        TimeOfDay(hour: 10, minute: 30), TimeOfDay(hour: 22, minute: 30)));
    l.add(restaurant(Icons.fastfood, 'Restarant D', 1.5, 40.36, ['Asian'],
        TimeOfDay(hour: 10, minute: 30), TimeOfDay(hour: 22, minute: 30)));
    l.add(restaurant(
        Icons.fastfood,
        'Restarant E',
        2.0,
        40.36,
        ['American Breakfast'],
        TimeOfDay(hour: 10, minute: 30),
        TimeOfDay(hour: 22, minute: 30)));
    l.add(restaurant(
        Icons.fastfood,
        'Restarant F',
        2.5,
        40.36,
        ['Chinese Breakfast'],
        TimeOfDay(hour: 10, minute: 30),
        TimeOfDay(hour: 22, minute: 30)));
    l.add(restaurant(Icons.fastfood, 'Restarant G', 3.0, 40.36, ['Milk Tea'],
        TimeOfDay(hour: 10, minute: 30), TimeOfDay(hour: 22, minute: 30)));
    l.add(restaurant(Icons.fastfood, 'Restarant H', 3.5, 40.36, ['Thai'],
        TimeOfDay(hour: 10, minute: 30), TimeOfDay(hour: 22, minute: 30)));
    l.add(restaurant(Icons.fastfood, 'Restarant I', 4.0, 40.36, ['Indian'],
        TimeOfDay(hour: 10, minute: 30), TimeOfDay(hour: 22, minute: 30)));
    l.add(restaurant(Icons.fastfood, 'Restarant J', 4.5, 40.36, ['Korean'],
        TimeOfDay(hour: 10, minute: 30), TimeOfDay(hour: 22, minute: 30)));
    l.add(restaurant(Icons.fastfood, 'Restarant K', 5.0, 87.12, ['Fast Food'],
        TimeOfDay(hour: 10, minute: 30), TimeOfDay(hour: 22, minute: 30)));

    return l;
  }

  /*
  * Builds a single entry of restaurant
  */
  Widget restaurant(
      IconData icon,
      String name,
      double rating,
      double averageCost,
      List<String> types,
      TimeOfDay openTime,
      TimeOfDay closeTime) {
    int numStars = rating.round(); // number of stars displayed
    String sTypes = types.toString(); // types of restaurant

    return Row(
      children: <Widget>[
        Container(width: 30), // Divider
        Icon(icon, color: Colors.black), // temporary, to be changed to image
        Container(width: 100), // Divider
        restaurantInfo(
            name, numStars, rating, averageCost, sTypes, openTime, closeTime),
      ],
    );
  }

  /*
  * Builds information of a restaurant
  */
  Column restaurantInfo(
      String name,
      int numStars,
      double rating,
      double averageCost,
      String sTypes,
      TimeOfDay openTime,
      TimeOfDay closeTime) {
    return Column(
      children: <Widget>[
        restaurantName(name),
        restaurantRatingAndAvgCost(numStars, rating, averageCost),
        restaurantTypes(sTypes),
        restaurantServiceTime(openTime, closeTime),
      ],
    );
  }

  /*
  * Builds service time of restaurant
  */
  Row restaurantServiceTime(TimeOfDay openTime, TimeOfDay closeTime) {
    return Row(
      children: <Widget>[
        // only get time part in TimeOfDay.toString
        Text(
            'Service Time: ' +
                openTime.toString().substring(10, 15) +
                ' - ' +
                closeTime.toString().substring(10, 15),
            style: blackTextStyleBasic),
      ],
    );
  }

  /*
  * Builds types of restaurant
  */
  Row restaurantTypes(String sTypes) {
    return Row(
      children: <Widget>[
        Text('Types: ' + sTypes.substring(1, sTypes.length - 1), // without []
            style: blackTextStyleBasic),
      ],
    );
  }

  /*
  * Builds rating and average cost of restaurant
  */
  Row restaurantRatingAndAvgCost(
      int numStars, double rating, double averageCost) {
    return Row(
      children: <Widget>[
        // stars of restaurants rating
        buildStars(numStars),
        Container(width: 10), // divider
        // rating text
        Text(rating.toStringAsFixed(1), style: blackTextStyleBasic),
        Container(width: 10), // divider
        // average cost text
        Text('\$' + averageCost.floor().toString(), style: blackTextStyleBasic),
      ],
    );
  }

  /*
  * Builds name of restaurant
  */
  Row restaurantName(String name) {
    return Row(
      children: <Widget>[
        Text(name, style: blackTextStyleBasic),
      ],
    );
  }

  /*
  * Builds stars rating of restaurant
  * */
  Row buildStars(int numStars) {
    List<Widget> l = new List<Widget>();

    // add yellow stars
    for (int i = 0; i < numStars; i++) {
      l.add(Icon(Icons.star, color: Colors.yellow));
    }

    // add black-bordered stars
    for (int i = numStars; i < 5; i++) {
      l.add(Icon(Icons.star_border, color: Colors.black));
    }

    return Row(
      children: l,
    );
  }

  /*
  * Shows AlertDialog with customized BuildContext, title, message, and exit
  * button text
  */
  Future<void> showAlertDialog(BuildContext context, String title,
      String message, String buttonText) async {
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
}
