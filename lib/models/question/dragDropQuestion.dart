import 'package:app_mvp/models/question/question.dart';

class DragDropQuestion extends Question {
  final List<String> draggableItem;
  final Map<String, String> correctMapping;

  DragDropQuestion({
    super.qid,
    required super.title,
    required super.answers,
    required this.draggableItem,
    required this.correctMapping,
  });
  factory DragDropQuestion.fromJson(Map<String, dynamic> json) {
    return DragDropQuestion(
      qid: json['qid'] as String,
      title: json['title'] as String,
      answers: [],
      draggableItem: List<String>.from(json['draggableItem']),
      correctMapping: Map<String, String>.from(json['correctMapping']),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'type': 'drag_drop',
      ...toBaseJson(),
      'draggableItem': draggableItem,
      'correctMapping': correctMapping
    };
  }
}