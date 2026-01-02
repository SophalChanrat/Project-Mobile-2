import 'package:app_mvp/models/answer.dart';
import 'package:app_mvp/models/question/question.dart';

class MultipleChoice extends Question {
  final List<String> choices;
  final String goodChoice;

  MultipleChoice({
    super.qid,
    required super.title,
    required super.answers,
    required this.choices,
    required this.goodChoice,
  });

  factory MultipleChoice.fromJson(Map<String, dynamic> json) {
    return MultipleChoice(
      qid: json['qid'] as String,
      title: json['title'] as String,
      answers: (json['answers'] as List)
          .map((answer) => Answer.fromJson(answer))
          .toList(),
      choices: List<String>.from(json['choices']),
      goodChoice: json['goodChoice'] as String,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'type': 'multiple_choice',
      ...toBaseJson(),
      'choices': choices,
      'goodChoice': goodChoice
    };
  }
}

