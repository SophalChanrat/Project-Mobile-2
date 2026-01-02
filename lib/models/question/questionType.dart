import 'package:app_mvp/models/question/arrangeAnswersQuestion.dart';
import 'package:app_mvp/models/question/dragDropQuestion.dart';
import 'package:app_mvp/models/question/multipleChoice.dart';
import 'package:app_mvp/models/question/question.dart';
import 'package:app_mvp/models/question/stepByStepQuestion.dart';

class QuestionType {
  static Question fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'multiple_choice':
        return MultipleChoice.fromJson(json);
      case 'step_by_step':
        return StepByStepQuestion.fromJson(json);
      case 'arrange_answer':
        return ArrangeAnswersQuestion.fromJson(json);
      case 'drag_drop':
        return DragDropQuestion.fromJson(json);
      default:
        throw Exception('Unknown question type: ${json['type']}');
    }
  }
}