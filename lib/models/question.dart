import 'package:app_mvp/models/answer.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Question {
  final String qid;
  final String title;
  final List<Answer> answer;

  Question({required this.title, required this.answer}) : qid = uuid.v4();

}

class MultipleChoice extends Question{
  final List<String> choices;
  final String goodChoice;

  MultipleChoice({
    required super.title,
    required super.answer,
    required this.choices,
    required this.goodChoice
  });
}

class StepByStepQuestion extends Question{
  final List<String> steps;
  final List<String> correctStep;

  StepByStepQuestion({
    required super.title,
    required super.answer,
    required this.steps,
    required this.correctStep
  });
}

class ArrangeAnswerQuestion extends Question{
  final List<String> items;
  final List<String> correctOrder;

  ArrangeAnswerQuestion({
    required super.title,
    required super.answer,
    required this.items,
    required this.correctOrder
  });
}

class DragDropQuestion extends Question{
  final List<String> draggableItem;
  final Map<String, String> correctMapping;

  DragDropQuestion({
    required super.title,
    required super.answer,
    required this.draggableItem,
    required this.correctMapping
  });
}