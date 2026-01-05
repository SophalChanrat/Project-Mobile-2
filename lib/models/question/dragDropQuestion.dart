import 'package:app_mvp/models/question/question.dart';

class DragDropQuestion extends Question {
  final List<String> draggableItem;
  final String correctAnswer;
  final int numberOfSlots;

  DragDropQuestion({
    super.qid,
    required super.title,
    required this.draggableItem,
    required this.correctAnswer,
    this.numberOfSlots = 2,
  });
  factory DragDropQuestion.fromJson(Map<String, dynamic> json) {
    return DragDropQuestion(
      qid: json['qid'] as String,
      title: json['title'] as String,
      draggableItem: List<String>.from(json['draggableItem']),
      correctAnswer: json['correctAnswer'] as String,
      numberOfSlots: json['numberOfSlots'] as int? ?? 2,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'type': 'drag_drop',
      ...toBaseJson(),
      'draggableItem': draggableItem,
      'correctAnswer': correctAnswer,
      'numberOfSlots': numberOfSlots,
    };
  }
}