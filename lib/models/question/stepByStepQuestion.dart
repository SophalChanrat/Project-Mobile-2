import 'package:app_mvp/models/answer.dart';
import 'package:app_mvp/models/question/question.dart';

class StepByStepQuestion extends Question {
  final List<String> steps;
  final List<String> correctStep;

  StepByStepQuestion({
    super.qid,
    required super.title,
    required super.answers,
    required this.steps,
    required this.correctStep,
  });
  factory StepByStepQuestion.fromJson(Map<String, dynamic> json) {
    return StepByStepQuestion(
      qid: json['qid'] as String,
      title: json['title'] as String,
      answers: (json['answers'] as List)
          .map((answer) => Answer.fromJson(answer))
          .toList(),
      steps: List<String>.from(json['steps']),
      correctStep: List<String>.from(json['correctStep']),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'type': 'step_by_step',
      ...toBaseJson(),
      'steps': steps,
      'correctStep': correctStep
    };
  }
}


