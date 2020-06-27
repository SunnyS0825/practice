import 'dart:async';
// import 'dart:html';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Message Center",
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: chatBars(),
    );
  }
}

class chatBars extends StatefulWidget{
  @override
  chatBarsState createState() => chatBarsState();
}
class chatBarsState extends State<chatBars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(),
            title: Text("user1", style: Theme.of(context).textTheme.subtitle.apply(color: Colors.black)),
            subtitle: Text("text",  style: Theme.of(context).textTheme.subtitle.apply(color: Colors.black)),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: _chatWindow,
            selected: true,
          ),
          ListTile(
            leading: CircleAvatar(),
            title: Text("user2", style: Theme.of(context).textTheme.subtitle.apply(color: Colors.black)),
            subtitle: Text("text", style: Theme.of(context).textTheme.subtitle.apply(color: Colors.black)),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: _chatWindow,
            selected: true,
          ),
          ListTile(
            leading: CircleAvatar(),
            title: Text("user3", style: Theme.of(context).textTheme.subtitle.apply(color: Colors.black)),
            subtitle: Text("text", style: Theme.of(context).textTheme.subtitle.apply(color: Colors.black)),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: _chatWindow,
            selected: true,
          ),
          ListTile(
            leading: CircleAvatar(),
            title: Text("user4", style: Theme.of(context).textTheme.subtitle.apply(color: Colors.black)),
            subtitle: Text("text", style: Theme.of(context).textTheme.subtitle.apply(color: Colors.black)),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: _chatWindow,
            selected: true,
          ),
        ],
      ),
    );
  }
  void _chatWindow() {
    Navigator.of(context).push(
      MaterialPageRoute<void> (
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: Row(mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(),
                    SizedBox(width: 15),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("user name"),
                          Text("Online"),
                        ]
                    )
                  ],
                ),
              ),

            );
          }
      ),
    );
  }
}

