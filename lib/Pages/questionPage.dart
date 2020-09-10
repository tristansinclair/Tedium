import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../main.dart';
import '../data/theme.dart';
import '../data/user.dart';

Color textColor = Colors.grey;

class QuestionPage extends StatefulWidget {
  final ActivityDataKai data;

  QuestionPage(this.data);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int questionCounter = 0;
  int numQuestions;

  void nextQuestion() {
    setState(
      () {
        questionCounter += 1;
        if (questionCounter >= numQuestions) resetCounter();
      },
    );
  }

  void resetCounter() {
    setState(
      () {
        questionCounter = 0;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> questions = [
      RandomQuestion(1, widget.data, nextQuestion),
      AgeQuestion(2, widget.data, nextQuestion),
      TransportationQuestion(3, widget.data, nextQuestion),
      FoodQuestion(4, widget.data, nextQuestion),
      SizeQuestion(5, widget.data, nextQuestion),
      BudgetQuestion(6, widget.data, nextQuestion)
    ];
    numQuestions = questions.length;

    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(children: [
          Center(
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width,
              lineHeight: 8,
              percent: questionCounter / numQuestions,
              progressColor: secondaryTheme,
              backgroundColor: Colors.transparent,
            ),
          ),
          questions[questionCounter]
        ] //you must add the questions and the answers here
            ),
      ),
    );
  }
}

class Question extends StatelessWidget {
  final int questionNum;
  final String questionText;

  Question(this.questionNum, this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(
        bottom: 5,
        left: 10,
        right: 10,
        top: 40,
      ),
      width: 800,
      padding: EdgeInsets.all(10),
      child: Row(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * .8,
          child: Text(
            questionText,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Colors.black,
            ),
          ),
        ),
      ]),
    );
  }
}

class RandomQuestion extends StatelessWidget {
  final int num;
  final ActivityDataKai data;
  final Question question;
  final List<String> answers = [
    "Eating a sandwich.",
    "Going hiking.",
    "Getting a massage.",
    "Winning the lottery."
  ];
  final void Function() parentAction;

  RandomQuestion(this.num, this.data, this.parentAction)
      : this.question = Question(num, "What sounds more fun?");

  @override
  Widget build(BuildContext context) {
    List<Widget> buttonsList = List<Widget>();
    buttonsList.add(question);
    for (int i = 0; i < answers.length; i++) {
      buttonsList.add(
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: textColor)),
            color: Colors.transparent,
            textColor: textColor,
            padding: EdgeInsets.all(8.0),
            onPressed: () => {data.type = answers[i], parentAction()},
            child: Text(
              answers[i],
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: buttonsList,
    );
  }
}

class AgeQuestion extends StatefulWidget {
  final int num;
  final ActivityDataKai data;
  final Question question;
  final void Function() parentAction;

  AgeQuestion(this.num, this.data, this.parentAction)
      : question = Question(num, "What is your age?");

  @override
  _AgeQuestionState createState() => _AgeQuestionState();
}

class _AgeQuestionState extends State<AgeQuestion> {
  bool isText = false;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Container continueButton = Container(
      height: 40,
      width: 200,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: secondaryTheme)),
        color: Colors.transparent,
        textColor: secondaryTheme,
        padding: EdgeInsets.all(8.0),
        onPressed: () => {
          setState(() {
            widget.data.age = int.parse(controller.text);
            print(widget.data.age);
            widget.parentAction();
          })
        },
        child: Text(
          "Continue",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );

    SizedBox textInput = SizedBox(
      width: MediaQuery.of(context).size.width * .3,
      child: new TextField(
        controller: controller,
        onChanged: (String value) => {
          setState(() {
            isText = value.isNotEmpty;
          })
        },
        maxLength: 2,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 100.0,
        ),
      ),
    );

    if (isText) {
      return Column(
        children: <Widget>[
          widget.question,
          textInput,
          SizedBox(height: 180),
          continueButton
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          widget.question,
          textInput,
          SizedBox(height: 180),
        ],
      );
    }
    // return Column(
    //   children: <Widget>[question, textInput, SizedBox(height: 180)],
    // );
  }
}

class FoodQuestion extends StatelessWidget {
  final int num;
  final ActivityDataKai data;
  final Question question;
  final void Function() parentAction;

  FoodQuestion(this.num, this.data, this.parentAction)
      : question = Question(num, "Are you hungry?");
  @override
  Widget build(BuildContext context) {
    Container yesButton = Container(
      margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 0),
      child: IconButton(
        iconSize: 25,
        color: textColor,
        icon: Icon(Icons.fastfood, color: Colors.white),
        onPressed: () => {data.food = true, parentAction(), print(data.food)},
      ),
      decoration: BoxDecoration(
        color: secondaryTheme,
        border: Border.all(
          color: secondaryTheme,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 55),
    );

    Container noButton = Container(
      margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 0),
      child: IconButton(
        iconSize: 25,
        color: tertiaryTheme,
        icon: Icon(Icons.close, color: Colors.white),
        onPressed: () => {data.food = false, parentAction(), print(data.food)},
      ),
      decoration: BoxDecoration(
        color: tertiaryTheme,
        border: Border.all(
          color: tertiaryTheme,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 55),
    );

    Image image = Image.asset('RedDot_Burger.jpg',
        width: 400, height: 300, fit: BoxFit.contain);

    return Column(
      children: <Widget>[
        question,
        image,
        Row(
          children: [noButton, yesButton],
          mainAxisAlignment: MainAxisAlignment.center,
        )
      ],
    );
  }
}

class SizeQuestion extends StatefulWidget {
  final int num;
  final ActivityDataKai data;
  final Question question;
  final void Function() parentAction;

  SizeQuestion(this.num, this.data, this.parentAction)
      : question = Question(num, "How many people?");

  @override
  _SizeQuestionState createState() => _SizeQuestionState();
}

class _SizeQuestionState extends State<SizeQuestion> {
  List<String> sizeTexts = ["Just Me", "Duo", "Trio", "Squad", "5+"];
  List<Color> slideColors = [tertiaryTheme, tertiaryTheme, tertiaryTheme, tertiaryTheme, tertiaryTheme];
  double sliderValue = 1;

  @override
  Widget build(BuildContext context) {
    String sizeText = sizeTexts[sliderValue.round() - 1];
    Color slideColor = slideColors[sliderValue.round() - 1];

    Container continueButton = Container(
      height: 40,
      width: 200,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: secondaryTheme)),
        color: Colors.transparent,
        textColor: secondaryTheme,
        padding: EdgeInsets.all(8.0),
        onPressed: () => {
          widget.data.size = sliderValue.round(),
          print(widget.data.size),
          widget.parentAction()
        },
        child: Text(
          "Continue",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );

    Container slider = Container(
      child: Align(
        child: Material(
          color: Colors.white,
          elevation: 10,
          borderRadius: BorderRadius.circular(24.0),
          shadowColor: secondaryTheme,
          child: Container(
            width: 350,
            height: 250,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 25.0, left: 16.0, right: 16.0, bottom: 16.0),
                  child: Container(
                    child: Text(
                      sizeText,
                      style: TextStyle(color: slideColor, fontSize: 70),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Slider(
                      min: 1,
                      max: 5,
                      divisions: 4,
                      value: sliderValue,
                      activeColor: slideColor,
                      inactiveColor: Colors.grey,
                      onChanged: (newValue) {
                        setState(() {
                          sliderValue = newValue;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    return Column(
      children: <Widget>[
        widget.question,
        slider,
        SizedBox(height: 70),
        continueButton
      ],
    );
  }
}

class TransportationQuestion extends StatefulWidget {
  final int num;
  final ActivityDataKai data;
  final Question question;
  final void Function() parentAction;
  final Map<String, IconData> transports = {
    "car": Icons.directions_car,
    "walking": Icons.directions_walk,
    "bus": Icons.directions_bus,
    "subway": Icons.directions_subway,
    "bike": Icons.directions_bike,
    "boat": Icons.directions_boat,
  };

  TransportationQuestion(this.num, this.data, this.parentAction)
      : question = Question(num, "What transportation do you have access to?");

  _TransportationQuestionState createState() => _TransportationQuestionState();
}

class _TransportationQuestionState extends State<TransportationQuestion> {
  List<String> transportation = List<String>();
  bool optionChosen = false;

  void _addTransportation(String transport) {
    setState(() {
      if (transportation.contains(transport)) {
        transportation.remove(transport);
      } else {
        transportation.add(transport);
      }
      optionChosen = transportation.isNotEmpty;
      print(transportation.toString());
    });
  }

  void setTransportation() {
    setState(() {
      widget.data.transportation = transportation;
      widget.parentAction();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> optionList = [];
    for (MapEntry<String, IconData> transport in widget.transports.entries) {
      bool pressed = transportation.contains(transport.key);
      optionList.add(
        Container(
          child: IconButton(
            highlightColor: secondaryTheme,
            iconSize: 40,
            color: textColor,
            icon: Icon(transport.value, color: pressed ? secondaryTheme : Colors.grey),
            onPressed: () => _addTransportation(transport.key),
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: pressed ? secondaryTheme : Colors.grey,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(7),
            ),
          ),
          padding: const EdgeInsets.all(8),
        ),
      );
    }

    SizedBox options = SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      height: MediaQuery.of(context).size.height * .4,
      child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: optionList),
    );

    Container continueButton = Container(
      height: 40,
      width: 200,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: secondaryTheme)),
        color: Colors.transparent,
        textColor: secondaryTheme,
        padding: EdgeInsets.all(8.0),
        onPressed: setTransportation,
        child: Text(
          "Continue",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );

    if (optionChosen) {
      return Column(
        children: [
          widget.question,
          options,
          continueButton,
        ],
      );
    } else {
      return Column(children: [widget.question, options]);
    }
  }
}

class BudgetQuestion extends StatefulWidget {
  final int num;
  final ActivityDataKai data;
  final Question question;
  final void Function() parentAction;

  BudgetQuestion(this.num, this.data, this.parentAction)
      : question = Question(num, "What is your budget?");

  _BudgetQuestionState createState() => _BudgetQuestionState();
}

class _BudgetQuestionState extends State<BudgetQuestion> {
  bool isText = false;
  var controller = new MoneyMaskedTextController(
      decimalSeparator: '.',
      thousandSeparator: ',',
      leftSymbol: 'US\$ ',
      precision: 2);

  @override
  Widget build(BuildContext context) {
    Container continueButton = Container(
      height: 40,
      width: 200,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: secondaryTheme)),
        color: Colors.transparent,
        textColor: secondaryTheme,
        padding: EdgeInsets.all(8.0),
        onPressed: () => {
          setState(() {
            widget.data.budget = controller.numberValue;
            print(widget.data.budget);
            widget.parentAction();
          })
        },
        child: Text(
          "Continue",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );

    SizedBox textInput = SizedBox(
      width: MediaQuery.of(context).size.width * .7,
      child: new TextField(
        onChanged: (String value) => {
          setState(() {
            isText = value.isNotEmpty;
          })
        },
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        maxLength: 8,
        maxLines: 2,
        keyboardType: TextInputType.number,
        // textDirection: TextDirection.rtl,
        controller: controller,

        //textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 50.0,
        ),
      ),
    );

    //this is a change
    if (isText) {
      return Column(
        children: <Widget>[
          widget.question,
          textInput,
          SizedBox(height: 180),
          continueButton
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          widget.question,
          textInput,
          SizedBox(height: 180),
        ],
      );
    }
  }
}
