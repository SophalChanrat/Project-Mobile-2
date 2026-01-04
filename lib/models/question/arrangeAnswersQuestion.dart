import 'package:app_mvp/models/question/question.dart';

class ArrangeAnswersQuestion extends Question {
  final List<String> items;
  final List<String> correctOrder;

  ArrangeAnswersQuestion({
    super.qid,
    required super.title,
    required this.items,
    required this.correctOrder,
  });
  factory ArrangeAnswersQuestion.fromJson(Map<String, dynamic> json) {
    return ArrangeAnswersQuestion(
      qid: json['qid'] as String,
      title: json['title'] as String,
      items: List<String>.from(json['items']),
      correctOrder: List<String>.from(json['correctOrder']),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'type': 'arrange_answer',
      ...toBaseJson(),
      'items': items,
      'correctOrder': correctOrder
    };
  }
}