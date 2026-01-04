import 'package:app_mvp/models/question/question.dart';

class StepByStepQuestion extends Question {
  final List<String> steps;
  final List<String> correctStep;
  final String content;

  StepByStepQuestion({
    super.qid,
    required super.title,
    required this.steps,
    required this.correctStep,
    required this.content
  });
  factory StepByStepQuestion.fromJson(Map<String, dynamic> json) {
    return StepByStepQuestion(
      qid: json['qid'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      steps: List<String>.from(json['steps']),
      correctStep: List<String>.from(json['correctStep']),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'type': 'step_by_step',
      ...toBaseJson(),
      'content': content,
      'steps': steps,
      'correctStep': correctStep
    };
  }
}


