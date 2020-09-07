import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardExpand extends PageRouteBuilder {
  final Widget page;
  CardExpand({this.page})
      : super(
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) =>
                page,
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) =>


                Stack(children: <Widget>[
                  FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                ]));
}
