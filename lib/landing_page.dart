import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:mspr1/Components/google_map.dart';

import 'package:mspr1/Components/messages_carousel.dart';

import 'Components/programmes_concerts.dart';

void main() => runApp(MaterialApp(home: LandingPage()));

class LandingPage extends StatefulWidget {
  @override
  _LandState createState() => new _LandState();
}

class _LandState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Container(
          color: const Color(0xff23272a),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 90.0,
                decoration: BoxDecoration(
                  color: const Color(0xff23272a),
                  border: Border(
                    bottom: BorderSide(
                      color: const Color(0xff2c2f33),
                      style: BorderStyle.solid,
                      width: 4.0
                    )
                  )
                ),
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: const Color(0xff23272a),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: IconButton(
                            icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }
                        ),
                      ),
                      Text(
                        "Live Events Menu",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                color: const Color(0xff23272a),
                child: Column(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.calendar_today_rounded, color: Colors.white,),
                          ),
                          Text('Programme', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                ProgrammeConcerts()
                        ));
                      },
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.shopping_cart_rounded, color: Colors.white,),
                          ),
                          Text('Billeterie', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        /* Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                ProgrammeConcerts()
                        )); */
                        debugPrint("Ouvrir billeterie");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Live Events'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: () => {
            _scaffoldKey.currentState.openDrawer(),
          },
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff2c2f33),
        bottom: PreferredSize(
            child: Container(
              color: Color(0xff23272a),
              height: 2.0,
            ),
            preferredSize: Size.fromHeight(2.0)),
      ),
      body: Container(
        color: const Color(0xff2c2f33),
        child: Column(
          children: [
            Flexible(
                // Messages urgents
                flex: 1,
                child: SizedBox(
                  height: 115.0,
                  child: MessageCarousel(type: "important-messages"),
                )),
            Flexible(
              // Programme des concerts
              flex: 1,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProgrammeConcerts()));
                    },
                    child: Column(
                      children: [
                        Text(
                          "Programme des concerts",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        Center(
                          child: Text(
                            "Cliquez ici pour avoir la liste complète des concerts ainsi que les heures de passages de vos artistes favoris !",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              // Billeterie
              flex: 1,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text("BILLETERIE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          )),
                      Text(
                          "Achetez vos billets depuis l'application en cliquant ici.",
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
                // Messages généraux
                flex: 1,
                child: SizedBox(
                  height: 115.0,
                  child: MessageCarousel(
                    type: "generic-messages",
                  ),
                )),
            Flexible(
              // Carte
              flex: 2,
              child: MapSample(),
            ),
          ],
        ),
      ),
    );
  }
}
