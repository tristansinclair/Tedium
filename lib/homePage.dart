import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'card.dart';
import 'data.dart';
import 'theme.dart';

LocationData locationData = LocationData(0, 0);

ActivityData testActivity = ActivityData(
    0,
    "Hiking the Dish",
    "this activity is just a test!",
    ["stanforddish.jpg"],
    0,
    3.5,
    locationData);
ActivityData testActivity2 = ActivityData(
    1,
    "Point Bonita Lighthouse",
    "this activity is just a test!",
    [
      "pointbonitalighthouse.jpg",
      "pointbonitalighthouse2.jpg",
      "pointbonitalighthouse3.jpg"
    ],
    0,
    4.9,
    locationData);
ActivityData testActivity3 = ActivityData(
    2,
    "Muir Beach Overlook",
    "this activity is just a test!",
    [
      "muirbeachoverlook.jpg",
      "muirbeachoverlook2.jpg",
      "muirbeachoverlook3.jpg"
    ],
    0,
    4.2,
    locationData);
ActivityData testActivity4 = ActivityData(
    3,
    "Half Moon Bay Sunset Lookout",
    "this activity is just a test!",
    [
      "halfmoonbaysunset.jpeg",
      "halfmoonbaysunset2.jpeg",
    ],
    0,
    5.0,
    locationData);

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
            child: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            titleSpacing: 0,
            pinned: false,
            snap: false,
            collapsedHeight: 65,
            title: Row(children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    "Explore",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: primaryFont,
                      color: const Color(0xff47455f),
                      fontWeight: FontWeight.w900,
                    ),
                  ))
            ]),
            backgroundColor: Colors.white,
            floating: false,
          ),
          SliverAppBar(
            collapsedHeight: 60,
            titleSpacing: 0,
            pinned: true,
            snap: false,
            title: Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  filled: true,
                  hintStyle: TextStyle(
                      color: Colors.grey[800],
                      fontFamily: primaryFont,
                      fontSize: 20),
                  hintText: "Search",
                  fillColor: CupertinoColors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    borderSide: BorderSide(color: CupertinoColors.systemGrey5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    borderSide: BorderSide(color: CupertinoColors.systemGrey5),
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            floating: false,
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 1500,
                      height: 330,
                      child: PageView(
                        pageSnapping: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          ActivityCard(testActivity),
                          ActivityCard(testActivity2),
                        ],
                      ),
                    ),
                    ActivityCard(testActivity3),
                    ActivityCard(testActivity4),
                  ],
                ),
              ),
            ],
          )),
        ])));
  }
}
