import 'package:flutter/material.dart';

List<int> fixedLengthList = new List(5);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizWidget(),
      debugShowCheckedModeBanner: false,
      // home: Scaffold(
      //   body: Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 0),
      //     child: ThreePageView(),
      //   ),
      // ),
    );
  }
}

class ThreePageView extends StatefulWidget {
  @override
  _ThreePageView createState() => _ThreePageView();
}

class _ThreePageView extends State<ThreePageView> {
  PageController _controller = PageController(
    initialPage: 1,
    //viewportFraction: 0.8
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        QuestionPage(),
        HomePage(),
        SocialPage(),
      ],
    );
  }
}

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Container(
        //   margin: EdgeInsets.only(
        //     bottom: 5,
        //     left: 10,
        //     right: 10,
        //     top: 5,
        //   ),
        //   width: 800,
        //   decoration: new BoxDecoration(
        //       borderRadius: new BorderRadius.all(Radius.circular(15.0)),
        //       color: Colors.blue),
        //   padding: EdgeInsets.all(10),
        //   child: Text(
        //     "Testing!",
        //     textAlign: TextAlign.center,
        //     overflow: TextOverflow.ellipsis,
        //     style: TextStyle(fontWeight: FontWeight.bold),
        //     textScaleFactor: 3,
        //   ),
        // ),
        //QuizWidget(),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Container(color: Colors.green),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: 5,
            left: 10,
            right: 10,
            top: 5,
          ),
          width: 800,
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(Radius.circular(15.0)),
            color: Colors.red,
          ),
          padding: EdgeInsets.all(10),
          child: Text(
            "Bored?",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
            textScaleFactor: 3,
          ),
        ),
      ],
    );
  }
}

class SocialPage extends StatefulWidget {
  @override
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Social Page',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
          textScaleFactor: 3,
        ),
      ],
    );
  }
}

// Data for building the questionaire
var data = [];
var questions = [
  "How many people are you with?",
  "What type of transportation do you have?",
  "What is your budget?"
];
var responses = {
  1: ["answer 1.1", "answer 1.2", "answer 1.3"],
  2: ["answer 2.1", "answer 2.2", "answer 2.3", "answer 2.4"],
  3: ["answer 3.1", "answer 3.2", "answer 3.3"],
};



class QuizWidget extends StatefulWidget {
  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  // VARIABLES
  int questionCounter = 1;
  String msg = 'Question to be asked';
  

  // FUNCTIONS
  // sets the state of the widget by increasing the counter up or down for the question
  void plusCounter() {
    setState(() { questionCounter += 1; });

    if (questionCounter > questions.length) {
      displayAnswers();
    }
  }

  // builds the buttons for w/ answers based off counter
  List<Widget> _buildButtonsWithAnswers(int questionNum) {
  void _onClick(String value) {
    data.add(value);
    plusCounter();
    print(value);
    print(data);
  }
  List<RaisedButton> buttonsList = new List<RaisedButton>();

  if (questionNum <= responses.length) {
    
    for (int i = 0; i < responses[questionNum].length; i++) {
    buttonsList.add(new RaisedButton(
        onPressed: () => _onClick(responses[questionNum][i]),
        child: Text(responses[questionNum][i])));
    }
    return buttonsList;
  } else {
    print("not enough questions");
  }
  return buttonsList;
  }

  // not completed... possible use of the navigation once figured out
  Widget displayAnswers() {
    return Container(
      child: Text("Answers!")
    );
  }


  // widget build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Questionaire"),
        backgroundColor: Colors.white10,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: _buildButtonsWithAnswers(questionCounter),

      )
    );
  }
}





class DisplayAnswers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Answers Here",
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
          ]
        )
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