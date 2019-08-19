import 'question.dart';

class QuizBrain {
  List<Question> questions = [
    new Question('Some cats are actually allergic to humans.', true),
    new Question('You can lead a cow down stairs but not up stairs.', false),
    new Question(
        'Approximately one quarter of human bones are in the feet.', true),
    new Question('A slug\'s blood is green.', true),
    new Question('It is illegal to pee in the Ocean in Portugal.', true),
  ];

  Question currentQuestion;
  int currentQuestionIndex = 0;
  int correctAnswerCounter = 0;
  int incorrectAnswerCounter = 0;

  QuizBrain() {
    this.currentQuestion = questions.first;
  }

  bool answerQuestion(bool answer) {
    if (this.currentQuestion.checkAnswerIsCorrect(answer)) {
      this.correctAnswerCounter++;
      return true;
    } else {
      this.incorrectAnswerCounter++;
      return false;
    }
  }

  bool hasQuizFinished() {
    return this.currentQuestionIndex >= questions.length - 1;
  }

  Question getNextQuestion() {
    this.currentQuestionIndex++;
    this.currentQuestion = this.questions[this.currentQuestionIndex];

    return this.currentQuestion;
  }

  restartQuiz() {
    this.currentQuestionIndex = 0;
    this.correctAnswerCounter = 0;
    this.incorrectAnswerCounter = 0;
    this.currentQuestion = questions.first;
  }
}
