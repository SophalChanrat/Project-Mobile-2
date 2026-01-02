import 'package:app_mvp/models/answer.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Submission {
  final String submissionId;
  final DateTime date;
  final int progress;
  final bool isComplete;
  final List<Answer> answers;

  Submission({
    String? submissionId,
    required this.date,
    required this.progress,
    required this.isComplete,
    required this.answers,
  }) : submissionId = submissionId ?? uuid.v4();

  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
      submissionId: json['submissionId'] as String,
      date: DateTime.parse(json['date'] as String),
      progress: json['progress'] as int,
      isComplete: json['isComplete'] as bool,
      answers: (json['answers'] as List)
          .map((answer) => Answer.fromJson(answer))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'submissionId': submissionId,
      'date': date.toString(),
      'progress': progress,
      'isComplete': isComplete,
      'answers': answers.map((answer) => answer.toJson()).toList(),
    };
  }
}
