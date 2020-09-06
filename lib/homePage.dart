import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'card.dart';
import 'data.dart';
import 'theme.dart';

LocationData locationData = LocationData(0, 0);

ActivityData testActivity = ActivityData(
    "Hiking the Dish",
    "this activity is just a test!",
    ["stanforddish.jpg"],
    0,
    3.5,
    locationData);

ActivityData testActivity2 = ActivityData(
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
            child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Explore",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: primaryFont,
                    color: const Color(0xff47455f),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                filled: true,
                hintStyle: TextStyle(
                  color: Colors.grey[800],
                  fontFamily: primaryFont,
                ),
                hintText: "Search",
                fillColor: CupertinoColors.systemGrey5,
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
          Container(
              height: 330,
              child:
                  PageView(
                    scrollDirection: Axis.horizontal, 
                    children: <Widget>[
                ActivityCard(testActivity),
                ActivityCard(testActivity2),
              ]))
        ])));
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
