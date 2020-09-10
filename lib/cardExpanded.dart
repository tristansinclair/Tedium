import 'package:flutter/material.dart';
import 'data/theme.dart';
import 'data/data.dart';
import 'card.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/cupertino.dart';

class ActivityScreen extends StatefulWidget {
  final ActivityData activityData;
  ActivityScreen({Key key, @required this.activityData}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState(activityData);
}

class _ActivityScreenState extends State<ActivityScreen>
    with TickerProviderStateMixin {
  final ActivityData activityData;
  _ActivityScreenState(this.activityData);

  final double infoHeight = 364.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: TediumTheme.nearlyWhite,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(children: <Widget>[
              Column(
                children: [
                  Hero(
                    tag: activityData.images[0],
                    child: ImageSlider(
                      images: activityData.images,
                      height: MediaQuery.of(context).size.height / 2.5,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Hero(
                      tag: activityData.name,
                      child: Text(
                        activityData.name,
                        style: TextStyle(
                          fontFamily: primaryFont,
                          fontSize: 28,
                          color: const Color(0xff47455f),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  Hero(
                    tag: activityData.rating,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity1,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          getTimeBoxUI(
                              activityData.rating.toString(), 'Rating'),
                          getTimeBoxUI("50 Miles", 'Away'),
                          getTimeBoxUI('128', 'Reviews'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: opacity2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 8),
                        child: Container(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 350.0,
                              maxWidth: 400.0,
                              minHeight: 30.0,
                              maxHeight: 200.0,
                            ),
                            child: Text(
                              "Muir Beach Overlook is part of the Golden Gate National Recreation Area. People may visit this cliffside park when driving on State Route 1 north of San Francisco, California and south of Stinson Beach, California. It has views of Pacific oceanside cliffs and on clear days you can see San Francisco.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: TediumTheme.nearlyBlack,
                              ),
                              maxLines: 10,
                              //overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity3,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, bottom: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 48,
                            height: 48,
                            child: Container(
                              decoration: BoxDecoration(
                                color: TediumTheme.nearlyWhite,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16.0),
                                ),
                                border: Border.all(
                                    color: TediumTheme.grey.withOpacity(0.2)),
                              ),
                              child: Icon(
                                Icons.add,
                                color: TediumTheme.amber,
                                size: 28,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          // Expanded(
                          //   child: InkWell(
                          //     onTap: () => {print("Join Courser pressed")},
                          //     child: Container(
                          //       height: 48,
                          //       decoration: BoxDecoration(
                          //         color: TediumTheme.amber,
                          //         borderRadius: const BorderRadius.all(
                          //           Radius.circular(16.0),
                          //         ),
                          //         boxShadow: <BoxShadow>[
                          //           BoxShadow(
                          //               color:
                          //                   TediumTheme.amber.withOpacity(0.5),
                          //               offset: const Offset(1.1, 1.1),
                          //               blurRadius: 10.0),
                          //         ],
                          //       ),
                          //       child: Center(
                          //         child: Text(
                          //           'Join Course',
                          //           textAlign: TextAlign.left,
                          //           style: TextStyle(
                          //             fontWeight: FontWeight.w600,
                          //             fontSize: 18,
                          //             letterSpacing: 0.0,
                          //             color: TediumTheme.nearlyWhite,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35 + 20,
                right: 20,
                child: ScaleTransition(
                  alignment: Alignment.center,
                  scale: CurvedAnimation(
                      parent: animationController, curve: Curves.fastOutSlowIn),
                  child: Card(
                    color: TediumTheme.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    elevation: 10.0,
                    child: Container(
                      width: 60,
                      height: 60,
                      child: Center(
                        child: Icon(
                          Icons.favorite_border,
                          color: TediumTheme.nearlyWhite,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: SizedBox(
                  width: AppBar().preferredSize.height,
                  height: AppBar().preferredSize.height,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(AppBar().preferredSize.height),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: TediumTheme.nearlyBlack,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              )
            ])));
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        color: TediumTheme.nearlyWhite,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: TediumTheme.amber,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: TediumTheme.nearlyBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
