class Question {
  String questionText;
  bool questionAnswer;

  Question(String text, bool answer) {
    this.questionText = text;
    this.questionAnswer = answer;
  }

  bool checkAnswerIsCorrect(bool answer) {
    return this.questionAnswer == answer;
  }
}
