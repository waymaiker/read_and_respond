
class QuestionModel {
  final List<String> options;
  final String answer;
  String proposition;

  QuestionModel({
    required this.options,
    required this.answer,
    this.proposition = ''
  });

  String getAnswer() => answer;

  int getAnswerIndex() => options.indexWhere((value) => value.toUpperCase() == getAnswer().toUpperCase());

  bool isFinished(){
    return proposition.isNotEmpty;
  }

  bool isSucceded(){
    return answer == proposition;
  }
}