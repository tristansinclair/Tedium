import 'package:flutter/material.dart';
import 'package:flutterapp/data/user.dart';
import 'Pages/socialPage.dart';
import 'Pages/homePage.dart';
import 'Pages/questionPage.dart';
import 'data/theme.dart'; // Theme Colors

List<int> fixedLengthList = new List(5);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = User(ActivityDataKai());
    var tabBarView = TabBarView(
                children: [
                  QuestionPage(user.data),
                  HomePage(),
                  SocialPage(),
                ],
              );
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          color: primaryTheme,
          home: DefaultTabController(
            initialIndex: 1,
            length: 3,
            child: Scaffold(
              body: tabBarView,
          bottomNavigationBar: TabBar(
            isScrollable: false,
            tabs: [
              Tab(
                icon: Icon(Icons.rss_feed),
              ),
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.perm_identity),
              ),
            ],
            labelColor: tertiaryTheme,
            unselectedLabelColor: secondaryTheme,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(22),
            indicatorColor: tertiaryTheme,
            labelPadding: EdgeInsets.fromLTRB(10, 5, 10, 15),
          ),
          backgroundColor: primaryTheme,
        ),
      ),
    );
  }
}

// when pressed
// when pressed add the value to the answer list
// change the values buttons to the next question
// change the question to the next question in the list

// things to add:
/* 
Return to the previous queston button:
  Reset the buttons
  Reset the quesion
  Fix the list for the new data input
*/

/* 
Display Screen
  take the answers list
  print the answer list
*/
