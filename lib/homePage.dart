import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'card.dart';
import 'data.dart';
import 'theme.dart';

import 'dart:math';
import 'package:flappy_search_bar/flappy_search_bar.dart';

ActivityData testActivity = createActivity("Hiking the Dish",
    "this activity is just a test!", ["stanforddish.jpg"], 0, 3.5);

ActivityData testActivity2 = createActivity(
    "Point Bonita Lighthouse",
    "this activity is just a test!",
    [
      "pointbonitalighthouse.jpg",
      "pointbonitalighthouse2.jpg",
      "pointbonitalighthouse3.jpg"
    ],
    0,
    4.9);

List<ActivityData> activityDataSet = [testActivity, testActivity2];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      filled: true,
                      hintStyle: new TextStyle(
                        color: Colors.grey[800],
                        fontFamily: primaryFont,
                      ),
                      hintText: "Search",
                      fillColor: CupertinoColors.systemGrey5,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide:
                            BorderSide(color: CupertinoColors.systemGrey5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: CupertinoColors.systemGrey5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Explore",
                          style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: primaryFont,
                            color: const Color(0xff47455f),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => print('See All'),
                          child: Text(
                            'See All',
                            style: TextStyle(
                              color: primaryTextColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: 330,
                      child: PageView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            ActivityCard(testActivity),
                            ActivityCard(testActivity2),
                          ]))
                ]))));
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}
