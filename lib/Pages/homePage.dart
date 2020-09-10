import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/data/data.dart';
import 'package:flutterapp/data/testdata.dart';
import '../card.dart';
import '../data/theme.dart';
import 'package:expansion_card/expansion_card.dart';

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
              
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 330,
                        viewportFraction: .8,
                        enableInfiniteScroll: false,
                      ),
                      items: [
                        ActivityCard(testActivity),
                        ActivityCard(testActivity2),
                        ActivityCard(testActivity5),
                      ],
                    ),
            ],
          )),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  ActivityCard(testActivity3),
                  ActivityCard(testActivity4),
                ],
              ),
              // Scrollable horizontal widget here
            ),
          ),
        ])));
  }
}
