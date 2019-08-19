import 'package:flutter/material.dart';
import 'question.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = new QuizBrain();

void main() => runApp(Quiz());

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Question _question = quizBrain.currentQuestion;
  List<Widget> _answerIcons = [];
  BuildContext _context;

  void answerQuestion(bool answer) {
    setState(() {
      if (quizBrain.answerQuestion(answer)) {
        _answerIcons.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        _answerIcons.add(Icon(
          Icons.clear,
          color: Colors.red,
        ));
      }

      if (quizBrain.hasQuizFinished()) {
        print('Quiz finished!');
        //showAlertDialog(_context, 'Quiz Finished!');
      } else {
        _question = quizBrain.getNextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white10,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 12,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        _question.questionText,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: FlatButton(
                    onPressed: () {
                      answerQuestion(true);
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text(
                      'True',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  flex: 2,
                  child: FlatButton(
                    onPressed: () {
                      answerQuestion(false);
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text(
                      'False',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: _answerIcons,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context, String message) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
//    title: Text("My title"),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
