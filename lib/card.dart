import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/cardExpanded.dart';
import 'package:flutterapp/cardExpansionAnimation.dart';
import 'data/data.dart';
import 'data/theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expansion_card/expansion_card.dart';

/**
 * * card.dart
 * Used to create "Cards" to display an activity
 * Takes in the ActivityData class and creates a card
 */

/**
 * * ActivityCard Widget
 * Creates an Activity Card widget for displaying activities
 */
class ActivityCard extends StatelessWidget {
  ActivityCard(this.activityData);
  final ActivityData activityData;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 1,
      color: Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(children: [
        Column(children: <Widget>[
          Hero(
            tag: activityData.images[0],
            child: ImageSlider(
              images: activityData.images,
              height: 250,
            ),
          ),
          Container(
              decoration: BoxDecoration(
                color: TediumTheme.nearlyWhite,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: TediumTheme.grey.withOpacity(0.2),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: ActivityCardText(activityData))
        ]),
        Positioned(
          left: 0.0,
          top: 0.0,
          bottom: 0.0,
          right: 0.0,
          child: GestureDetector(
            onTap: () async {
              await Future.delayed(Duration(milliseconds: 200));
              Navigator.push(
                  context,
                  CardExpand(
                    page: ActivityScreen(activityData: activityData),
                  ));
            },
          ),
        ),
        Positioned(
            right: 20,
            top: 20,
            child: Stack(children: <Widget>[
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.favorite_border,
                      size: 30,
                      color: white,
                    ),
                  ),
                ),
              ),
            ])),
      ]),
    );
  }
}

class ActivityCardText extends StatelessWidget {
  ActivityCardText(this.activityData);
  final ActivityData activityData;
  @override
  Widget build(BuildContext context) {
    return Material(
        child: ListTile(
            title: Hero(
              tag: activityData.name,
              child: Text(
                activityData.name,
                style: TextStyle(
                  fontFamily: primaryFont,
                  fontSize: 22,
                  color: const Color(0xff47455f),
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            subtitle: Hero(
              tag: activityData.rating,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                RatingBarIndicator(
                  rating: activityData.rating,
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
                SizedBox(width: 10),
                Text(
                  // Secondary text (Distance maybe?)
                  activityData.distance,
                  style: TextStyle(
                    fontFamily: primaryFont,
                    fontSize: 16,
                    color: primaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
              ]),
            )));
  }
}

class ImageSlider extends StatefulWidget {
  final List<String> images;
  final double height;

  const ImageSlider({Key key, this.images, this.height}) : super(key: key);

  _ImageSliderState createState() => _ImageSliderState(images, height);
}

class _ImageSliderState extends State<ImageSlider> {
  List<String> images;
  double height;
  _ImageSliderState(this.images, this.height);

  int _current = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CarouselSlider(
        options: CarouselOptions(
            enableInfiniteScroll: false,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            height: height,
            initialPage: index,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
        items: widget.images
            .map(
              (item) => SizedBox(
                  //height: height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    "assets/images/$item",
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  )),
            )
            .toList(),
      ),
      if (images.length > 1)
        SafeArea(
          top: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.map((url) {
              int index = images.indexOf(url);
              return Container(
                width: 6.0,
                height: 6.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? primaryTextColor.withOpacity(.5)
                      : secondaryTextColor,
                ),
              );
            }).toList(),
          ),
        )
    ]);
  }
}

class MiniCard extends StatelessWidget {
  MiniCard(this.activityData);
  final ActivityData activityData;

  @override
  Widget build(BuildContext context) {
    return ExpansionCard(
      borderRadius: 20,
      background: Image.asset(
        "assets/images/${activityData.images[0]}",
        fit: BoxFit.cover,
      ),
      title: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              activityData.name,
              style: TextStyle(
                fontFamily: primaryFont,
                fontSize: 22,
                color: TediumTheme.nearlyWhite,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              activityData.rating.toString(),
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
      ),
      children: <Widget>[
        Container(
            margin: EdgeInsets.symmetric(horizontal: 7),
            child: Text(
              "Content goes over here !",
              style: TextStyle(
                fontFamily: primaryFont,
                fontSize: 16,
                color: TediumTheme.nearlyWhite,
                fontWeight: FontWeight.w500,
              ),
            ))
      ],
    );
  }
}
