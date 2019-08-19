import 'package:flutter/material.dart';
import 'question.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = new QuizBrain();

void main() => runApp(MaterialApp(
      home: Quiz(),
    ));

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Question _question = quizBrain.currentQuestion;
  List<Widget> _answerIcons = [];
  BuildContext appContext;
  bool shownLastAnswerIcon = false;

  void restartQuiz() {
    setState(() {
      quizBrain.restartQuiz();
      _answerIcons = [];
      shownLastAnswerIcon = false;
      _question = quizBrain.currentQuestion;
    });
  }

  void answerQuestion(bool answer) {
    setState(() {
      if (quizBrain.hasQuizFinished()) {
        print('Quiz finished!');

        if (!shownLastAnswerIcon) {
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

          shownLastAnswerIcon = true;
        }

        showAlert();
      } else {
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

        _question = quizBrain.getNextQuestion();
      }
    });
  }

  void showAlert() {
    int correctAnswers = quizBrain.correctAnswerCounter;
    int incorrectAnswers = quizBrain.incorrectAnswerCounter;

    Alert(
      context: appContext,
      title: 'Quiz Finished',
      desc:
          'You have $correctAnswers correct and $incorrectAnswers incorrect answers.',
      buttons: [
        DialogButton(
          child: Text(
            'Restart Quiz',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            restartQuiz();
            Navigator.pop(appContext);
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
      style: AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        animationDuration: Duration(milliseconds: 400),
      ),
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    appContext = context;

    return Scaffold(
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
    );
  }
}
