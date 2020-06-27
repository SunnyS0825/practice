import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter/services.dart';
import 'Styles.dart';

class Discount {
  String imageURL, name, time, price;

  Discount(String imageURL, String name, String time, String price) {
    this.imageURL = imageURL;
    this.name = name;
    this.time = time;
    this.price = price;
  }

  Discount clone() {return Discount(imageURL, name, time, price);}
}

class Combo {
  String imageURL, name, time, price;

  Combo(String imageURL, String name, String time, String price) {
    this.imageURL = imageURL;
    this.name = name;
    this.time = time;
    this.price = price;
  }

  Combo clone() {return Combo(imageURL, name, time, price);}
}

class Signature {
  String imageURL, name;

  Signature(String imageURL, String name) {
    this.imageURL = imageURL;
    this.name = name;
  }

  Signature clone() {return Signature(imageURL, name);}
}

class Popular {
  String imageURL, name;

  Popular(String imageURL, String name) {
    this.imageURL = imageURL;
    this.name = name;
  }

  Popular clone() {return Popular(imageURL, name);}
}

class Reply {
  String userImageURL, username, date, text;

  Reply(String userImageURL, String username, String date, String text) {
    this.userImageURL = userImageURL;
    this.username = username;
    this.date = date;
    this.text = text;
  }

  Reply clone() {return Reply(userImageURL, username, date, text);}
}

class Comment {
  String userImageURL, username, date, text;
  var images = <String>[];
  double rating;
  bool hasReply;
  List<Reply> replies;

  Comment(String userImageURL, String username, String date, String text,
      List<String> images, double rating, bool hasReply, List<Reply> replies) {
    this.userImageURL = userImageURL;
    this.username = username;
    this.date = date;
    this.text = text;
    this.images = images;
    this.rating = rating;
    this.hasReply = hasReply;
    this.replies = replies;
  }

  List<Reply> cloneReplies() {

    var newRs = new List<Reply>();
    for (var r in replies) {

      newRs.add(r.clone());
    }

    return newRs;
  }

  Comment clone() {return Comment(userImageURL, username, date, text, images, rating, hasReply, cloneReplies());}
}

class Recommendation {
  String imageURL, name, style;
  double rating, distance, price;

  Recommendation(String imageURL, String name, String style, double rating,
      double distance, double price) {
    this.imageURL = imageURL;
    this.name = name;
    this.style = style;
    this.rating = rating;
    this.distance = distance;
    this.price = price;
  }

  Recommendation clone() {return Recommendation(imageURL, name, style, rating, distance, price);}
}

class RestaurantPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RestaurantPageState();
  }
}

class RestaurantPageState extends State<RestaurantPage> {
  final key1 = new GlobalKey();
  final key2 = new GlobalKey();
  final key3 = new GlobalKey();
  final key4 = new GlobalKey();

  double rating = 4.82;
  var numRatings = 3534;

  var rating1 = 4.83;
  var rating2 = 4.23;
  var rating3 = 4.18;
  var rating4 = 4.55;

  var costRange = 223;

  var informationList = List();

  var discounts = List();
  var combos = List();
  var signatures = List<Signature>();
  var popular = List();
  var commentKeywords = List();
  var comments = List();
  int totalComments;
  var recommendations = List();

  var d1;

  @override
  Widget build(BuildContext context) {
    Discount discount = new Discount(
        'https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2013/05/epic-summer-salad.jpg',
        'Name',
        'Time',
        'Price');
    discounts.addAll([discount, discount.clone()]);

    Combo combo = new Combo(
        'https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2013/05/epic-summer-salad.jpg',
        'Name',
        'Time',
        'Price');
    combos.addAll([combo, combo.clone()]);

    Signature signature = new Signature(
        'https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2013/05/epic-summer-salad.jpg',
        'Name');
    signatures.addAll([signature, signature.clone(), signature.clone(), signature.clone(), signature.clone()]);

    Popular pop = new Popular(
        'https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2013/05/epic-summer-salad.jpg',
        'Name');
    popular.addAll([pop, pop.clone(), pop.clone(), pop.clone(), pop.clone()]);

    Reply reply = new Reply(
        'https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2013/05/epic-summer-salad.jpg',
        'username',
        'Date',
        'Text');
    Comment comment = new Comment(
        'https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2013/05/epic-summer-salad.jpg',
        'username',
        'Date',
        'Text',
        [
          'https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2013/05/epic-summer-salad.jpg',
          'https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2013/05/epic-summer-salad.jpg'
        ],
        4.2,
        true,
        [
          reply,
          reply.clone()
        ]);
    comments.addAll([comment, comment.clone()]);

    Recommendation recommendation = new Recommendation(
        'https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2013/05/epic-summer-salad.jpg',
        'Name',
        'Style',
        4.2,
        1.5,
        25);
    recommendations.addAll([recommendation, recommendation.clone(), recommendation.clone()]);

    commentKeywords
        .addAll(["key", "key", "key", "key", "key", "key", "key", "key"]);

    informationList.add(Column(
      key: key1,
      //discounts
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(5),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Discounts', style: blackTextStyleMedium)))
      ] +
      _buildDiscounts() +
      <Widget>[
        Padding(
            padding: EdgeInsets.all(5),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Combos', style: blackTextStyleMedium)))
      ] +
      _buildCombos(),
    ));

    informationList.add(Column(
      key: key2,
      //foods
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(5),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Signature Dishes', style: blackTextStyleMedium))),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _buildSignatures())
        ),
        Padding(
            padding: EdgeInsets.all(5),
            child: Align(
                alignment: Alignment.centerLeft,
                child:
                Text('Recommended Dishes', style: blackTextStyleMedium))),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _buildPopular())
        )
      ],
    ));

    informationList.add(Column(
      key: key3,
      //comments
      children: <Widget>[
        GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 4,
            childAspectRatio: 2.5,
            padding: EdgeInsets.all(5),
            children: _buildKeys()),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Comments', style: blackTextStyleMedium))
      ] +
          _buildComments(),
    ));

    informationList.add(() {
      if (recommendations.length > 0) {
        return Column(children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Text('People Also Like', style: blackTextStyleMedium)),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            key: key4,
            //recommendations
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            children: _buildRecommendations(),
          )
        ]);
      } else {
        return Align(
            alignment: Alignment.centerLeft,
            child: Text('People Also Like', style: blackTextStyleMedium));
      }
    }());

    print("debug 201 " + informationList.toString());

    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: CustomScrollView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            slivers: <Widget>[
              //Header
              SliverToBoxAdapter(
                  child: Stack(
                    children: <Widget>[
                      Image(
                        //ad
                          image: AssetImage("assets/people1.jpg"),
                          fit: BoxFit.contain),
                      Positioned.fill(
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  //image, video
                                  ClipOval(
                                      child: Material(
                                          color: Colors.black.withOpacity(0.5),
                                          child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Icon(Icons.image,
                                                  color: Colors.white)))),
                                  ClipOval(
                                      child: Material(
                                          color: Colors.black.withOpacity(0.5),
                                          child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Icon(Icons.videocam,
                                                  color: Colors.white))))
                                ],
                              )))
                    ],
                  )),
              SliverToBoxAdapter(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                      child: Text("Restaurant Title",
                          textAlign: TextAlign.left,
                          style: blackTextStyleMedium))),
              SliverToBoxAdapter(
                  child: Row(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                          child: _buildStars(rating)),
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(rating.toString(),
                              textAlign: TextAlign.left,
                              style: blackTextStyleBasic)),
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(numRatings.toString() + " ratings",
                              textAlign: TextAlign.left,
                              style: blackTextStyleBasic)),
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(costRange.toString(),
                              textAlign: TextAlign.left,
                              style: blackTextStyleBasic)),
                    ],
                  )),
              SliverToBoxAdapter(
                  child: Row(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                          child: Text("Taste: " + rating1.toString(),
                              textAlign: TextAlign.left,
                              style: blackTextStyleBasic)),
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: Text("Service: " + rating2.toString(),
                              textAlign: TextAlign.left,
                              style: blackTextStyleBasic)),
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: Text("Vibe: " + rating3.toString(),
                              textAlign: TextAlign.left,
                              style: blackTextStyleBasic)),
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: Text("Worth: " + rating4.toString(),
                              textAlign: TextAlign.left,
                              style: blackTextStyleBasic)),
                    ],
                  )),
              SliverToBoxAdapter(
                  child: Row(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                          child: Text("Type of food",
                              textAlign: TextAlign.left,
                              style: blackTextStyleBasic)),
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: Text("Location",
                              textAlign: TextAlign.center,
                              style: blackTextStyleBasic))
                    ],
                  )),
              SliverToBoxAdapter(
                  child: Row(
                    children: <Widget>[
                      //tags
                      Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                          child: Text("tags",
                              textAlign: TextAlign.center,
                              style: blackTextStyleBasic))
                    ],
                  )),
              SliverToBoxAdapter(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 15,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                              child: Text("Address",
                                  textAlign: TextAlign.left,
                                  style: blackTextStyleBasic))),
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child:
                              Icon(Icons.directions_car, color: Colors.blue))),
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.phone, color: Colors.orange))),
                    ],
                  )),
              SliverToBoxAdapter(
                  child: Card(
                      child: Row(
                        children: <Widget>[
                          //checkbox, booking info
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.check_box, color: Colors.lightGreen)),
                          Expanded(
                              flex: 15,
                              child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "Booking available",
                                    style: blackTextStyleBasic,
                                  ))),
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("Times booked")))
                        ],
                      ))),

              new SliverStickyHeader(
                  header: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                            flex: 7,
                            child: FlatButton(
                              color: Colors.white,
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                              onPressed: () =>
                                  Scrollable.ensureVisible(key1.currentContext),
                              child: Text("Discounts"),
                            )),
                        Expanded(
                            flex: 0,
                            child: FlatButton(
                              color: Colors.white,
                              padding: EdgeInsets.all(0),
                              onPressed: () =>
                                  Scrollable.ensureVisible(key2.currentContext),
                              child: Text("Food"),
                            )),
                        Expanded(
                            flex: 7,
                            child: FlatButton(
                              color: Colors.white,
                              padding: EdgeInsets.all(0),
                              onPressed: () =>
                                  Scrollable.ensureVisible(key3.currentContext),
                              child: Text("Comments"),
                            )),
                        Expanded(
                            flex: 11,
                            child: FlatButton(
                              color: Colors.white,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                              onPressed: () =>
                                  Scrollable.ensureVisible(key4.currentContext),
                              child: Text("Recommended"),
                            )),
                      ],
                  )),
                  sliver: new SliverList(
                    delegate: new SliverChildBuilderDelegate(
                            (context, i) => informationList[i],
                        childCount: 4),
                  ))
            ]));
    /*SliverStickyHeader(

          header: Row(

            children: <Widget>[

              RaisedButton(

                  onPressed: () => Scrollable.ensureVisible(key1.currentContext),
                  child: Text("Discount"),
              ),
              RaisedButton(

                  onPressed: () => Scrollable.ensureVisible(key2.currentContext),
                  child: Text("Food"),
              ),
              RaisedButton(

                  onPressed: () => Scrollable.ensureVisible(key3.currentContext),
                  child: Text("Comments"),
              ),
              RaisedButton(

                  onPressed: () => Scrollable.ensureVisible(key4.currentContext),
                  child: Text("Recommendations"),
              ),
            ],
          ),

          sliver: SliverList(

            delegate: SliverChildBuilderDelegate(
                (context, i) => informationList[i],
                childCount: 4,
            )
          )
        ),*/
  }

  Widget _buildStars(double rating) {
    double numStars = (rating * 2).round() / 2;

    var stars = List();

    for (double i = 0; i < 5; i++) {
      if (i + 1 <= numStars) {
        stars.add(Padding(
            padding: EdgeInsets.all(1),
            child: Directionality(
                textDirection: TextDirection.ltr,
                child: Icon(Icons.star, color: Colors.yellow))));
      } else if (i + 0.5 <= numStars) {
        stars.add(Padding(
            padding: EdgeInsets.all(1),
            child: Directionality(
                textDirection: TextDirection.ltr,
                child: Icon(Icons.star_half, color: Colors.yellow))));
      } else {
        stars.add(Padding(
            padding: EdgeInsets.all(1),
            child: Directionality(
                textDirection: TextDirection.ltr,
                child: Icon(Icons.star_border, color: Colors.yellow))));
      }
    }

    return Row(
      children: <Widget>[stars[0], stars[1], stars[2], stars[3], stars[4]],
    );
  }

  List<Widget> _buildDiscounts() {
    var discountWidgets = List<Widget>();

    for (var d in discounts) {
      discountWidgets.add(
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(5),
                  child: SizedBox(
                      height: 125, width: 125, child: Image.network(d.imageURL, fit: BoxFit.cover))),
              Expanded(
                  flex: 10,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 1),
                            child: Text(d.name, style: blackTextStyleBasic)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 1),
                            child: Text(d.time, style: blackTextStyleBasic)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text(d.price, style: blackTextStyleBasic))
                      ]))),
              Padding(
                  padding: EdgeInsets.all(5),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Material(
                              color: Colors.red,
                              child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child:
                                  Text("Order", style: whiteTextStyleBasic))))))
            ],
          ));
    }

    return discountWidgets;
  }

  List<Widget> _buildCombos() {
    var comboWidgets = List<Widget>();

    for (var c in combos) {
      comboWidgets.add(
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(5),
                  child: SizedBox(
                      height: 125, width: 125, child: Image.network(c.imageURL, fit: BoxFit.cover))),
              Expanded(
                  flex: 10,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 1),
                            child: Text(c.name, style: blackTextStyleBasic)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 1),
                            child: Text(c.time, style: blackTextStyleBasic)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 1),
                            child: Text(c.price, style: blackTextStyleBasic))
                      ]))),
              Padding(
                  padding: EdgeInsets.all(5),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Material(
                              color: Colors.red,
                              child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child:
                                  Text("Order", style: whiteTextStyleBasic))))))
            ],
          ));
    }

    return comboWidgets;
  }

  List<Widget> _buildSignatures() {
    var signatureWidgets = List<Widget>();

    for (var s in signatures) {

      print(s);
      signatureWidgets.add(Column(children: <Widget>[
        Padding(
            padding: EdgeInsets.all(5),
            child: SizedBox(
                height: 125, width: 125, child: Image.network(s.imageURL, fit: BoxFit.cover,))),
        Padding(
            padding: EdgeInsets.all(5),
            child: Text(s.name, style: blackTextStyleBasic))
      ]));
    }

    return signatureWidgets;
  }

  List<Widget> _buildPopular() {
    var popularWidgets = List<Widget>();

    for (var p in popular) {
      popularWidgets.add(Column(children: <Widget>[
        Padding(
            padding: EdgeInsets.all(5),
            child: SizedBox(
                height: 125, width: 125, child: Image.network(p.imageURL, fit: BoxFit.cover))),
        Padding(
            padding: EdgeInsets.all(5),
            child: Text(p.name, style: blackTextStyleBasic))
      ]));
    }

    return popularWidgets;
  }

  List<Widget> _buildComments() {
    var commentWidgets = List<Widget>();

    for (var c in comments) {
      var commentWidgetComponents = List<Widget>();
      var attachedImages = List<Widget>();

      for (var i in c.images) {
        attachedImages.add(Padding(
            padding: EdgeInsets.all(5),
            child: SizedBox(height: 100, width: 100, child: Image.network(i, fit: BoxFit.cover))));
      }

      commentWidgetComponents.add(
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Padding(
                padding: EdgeInsets.all(5),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                        radius: 25,
                        backgroundImage: Image.network(c.userImageURL, fit: BoxFit.cover).image))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Text(c.username, style: blackTextStyleBold)),
                Padding(
                    padding: EdgeInsets.fromLTRB(5, 1, 5, 0),
                    child: Text(c.date, style: blackTextStyleBasic)),
                Row(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(5, 1, 5, 0),
                      child: Text(c.rating.toString(), style: blackTextStyleBasic)),
                  _buildStars(rating)
                ]),
                Padding(
                    padding: EdgeInsets.fromLTRB(5, 1, 5, 0),
                    child: Text(c.text, style: blackTextStyleBasic)),
                Padding(
                    padding: EdgeInsets.fromLTRB(5, 1, 5, 5),
                    child: Row(children: attachedImages))
              ],
            )
          ]));

      if (c.hasReply) {
        for (var r in c.replies) {
          commentWidgetComponents.add(Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: CircleAvatar(
                            radius: 25,
                            backgroundImage:
                            Image.network(r.userImageURL).image)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 1),
                            child: Text(r.username, style: blackTextStyleBold)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 1),
                            child: Text(r.date, style: blackTextStyleBasic)),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                            child: Text(r.text, style: blackTextStyleBasic)),
                      ],
                    )
                  ])));
        }
      }

      commentWidgets.add(Column(children: commentWidgetComponents));
    }

    return commentWidgets;
  }

  List<Widget> _buildRecommendations() {
    var recommendationWidgets = List<Widget>();

    for (var r in recommendations) {
      recommendationWidgets.add(Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(5),
              child: SizedBox(height: 150, width: 150, child: Image.network(r.imageURL, fit: BoxFit.cover))),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 1, 0, 0),
              child: Text(r.name, style: blackTextStyleBasic)),
          Row(
            children: <Widget>[
              _buildStars(r.rating),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 1, 0, 0),
                  child: Text('\$' + r.price.toString() + '/p',
                      style: blackTextStyleBasic)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 1, 0, 0),
                  child: Text(r.style.toString(), style: blackTextStyleBasic)),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 1, 0, 0),
                  child:
                  Text(r.distance.toString(), style: blackTextStyleBasic)),
            ],
          ),
        ],
      ));
    }

    return recommendationWidgets;
  }

  List<Widget> _buildKeys() {
    var keyWidgets = List<Widget>();
    for (var k in commentKeywords) {
      keyWidgets.add(Padding(
          padding: EdgeInsets.all(5),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Material(
                  color: Colors.red,
                  child: Center(
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            k,
                            style: whiteTextStyleBasic,
                            textAlign: TextAlign.center,
                          )))))));
    }

    return keyWidgets;
  }
}
