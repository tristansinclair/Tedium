import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/card_2.dart';
import 'data.dart';
import 'theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/**
 * * card.dart
 * Used to create "Cards" to display an activity
 * Takes in the ActivityData class and creates a card
 * based off the data stored
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
          //ImageSlider(activityData.images, 250),
          Hero(tag: activityData.name, child: ActivityCardText(activityData))
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
                MaterialPageRoute(
                  builder: (context) =>
                      ActivityCardExpansion(activityData: activityData),
                  fullscreenDialog: true,
                ),
              );
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
          title: Text(
            activityData.name,
            style: TextStyle(
              fontFamily: primaryFont,
              fontSize: 22,
              color: const Color(0xff47455f),
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.left,
          ),
          subtitle: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
            Container(width: 10),
            Text(
              // Secondary text (Distance maybe?)
              'distance',
              style: TextStyle(
                fontFamily: primaryFont,
                fontSize: 16,
                color: primaryTextColor,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ])),
    );
  }
}

class ActivityCardExpansion extends StatefulWidget {
  final ActivityData activityData;

  const ActivityCardExpansion({Key key, this.activityData}) : super(key: key);

  _ActivityCardExpansionState createState() =>
      _ActivityCardExpansionState(activityData);
}

class _ActivityCardExpansionState extends State<ActivityCardExpansion> {
  ActivityData activityData;
  _ActivityCardExpansionState(this.activityData);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(width);

    return Stack(children: <Widget>[
      Material(
        child: Stack(children: [
          Column(children: <Widget>[
            Hero(
              tag: activityData.images[0],
              child: ImageSlider(
                images: activityData.images,
                height: 350,
              ),
            ),

            //ImageSlider(activityData.images, 400),
            Hero(
              tag: activityData.name,
              child: ActivityCardText(activityData),
            ),
            Expanded(
              child: Center(child: Text("Some more content goes here!")),
            ),
          ]),
          Positioned(
              right: 15,
              top: 30,
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
      ),
      Positioned(
          left: 15,
          top: 30,
          child: Stack(children: <Widget>[
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.cancel,
                    size: 30,
                    color: white,
                  ),
                ),
              ),
            ),
          ])),
    ]);
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
    double width = MediaQuery.of(context).size.width;
    return Stack(children: [
      CarouselSlider(
        options: CarouselOptions(
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            height: height,
            enableInfiniteScroll: false,
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
        Row(
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
        )
    ]);
  }
}