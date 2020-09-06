import 'package:flutter/material.dart';
import 'package:flutterapp/data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutterapp/card.dart';
import 'package:flutterapp/theme.dart';

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

    _launchMap(BuildContext context, lat, lng) async {
      var url = '';
      var urlAppleMaps = '';

      urlAppleMaps = 'https://maps.apple.com/?q=$lat,$lng';
      url = "comgooglemaps://saddr=&daddr=$lat,$lng&directionsmode=driving";
      launch(urlAppleMaps);
    }

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
            Container(
                child: RaisedButton(
              onPressed: () => {_launchMap(context, 37.815700, -122.529407)},
            )),
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
