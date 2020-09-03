import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';
import 'card.dart';
//import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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




class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    this.closedBuilder,
    this.transitionType,
    this.onClosed,
    this.activityData
  });
  final ActivityData activityData;
  final OpenContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool> onClosed;

  @override
  Widget build(BuildContext context) {
    print("instance of OpenContainerWrapper");
    print(activityData);

    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {

        return DetailsPage(activityData: activityData);
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}

class ExampleSingleTile extends StatelessWidget {
  const ExampleSingleTile({this.openContainer, this.activityData});
  final ActivityData activityData;
  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    const double height = 100.0;

    return _InkWellOverlay(
      openContainer: openContainer,
      height: height,
      child: Row(
        children: <Widget>[
          Container(
            color: Colors.black38,
            height: height,
            width: height,
            child: Center(
              child: Image.asset(
                'assets/images/pointbonitalighthouse.jpg',
                width: 60,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Title',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                      'Lorem ipsum dolor sit amet, consectetur '
                      'adipiscing elit,',
                      style: Theme.of(context).textTheme.caption),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InkWellOverlay extends StatelessWidget {
  const _InkWellOverlay({
    this.openContainer,
    this.width,
    this.height,
    this.child,
  });

  final VoidCallback openContainer;
  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: GestureDetector(
        onTap: openContainer,
        child: child,
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({this.includeMarkAsDoneButton = true, this.activityData});

  final ActivityData activityData;
  final bool includeMarkAsDoneButton;

  @override
  Widget build(BuildContext context) {
    print("test:");
    print(activityData);
    return Stack(children: <Widget>[
   Material(
          child: Stack(children: [
            Column(children: <Widget>[
              ImageSlider(activityData.images, 400),
            
              //ImageSlider(activityData.images, 400),
              ActivityCardText(activityData),
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


class ImageSlider extends StatelessWidget {
  List<String> images;
  double height;
  ImageSlider(this.images, this.height);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        height: height,
        enableInfiniteScroll: false,
        initialPage: 0,
      ),
      items: images
          .map(
            (item) => Container(
                child: Image.asset("assets/images/$item", fit: BoxFit.cover)),
          )
          .toList(),
    );
  }
}