import 'package:app_mvp/models/feedback.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Answer {
  final String aid;
  final String questionId;
  final String response;
  final int attempsCount;
  final FeedbackModel feedback;

  Answer({
    String? aid,
    required this.questionId,
    required this.response,
    required this.attempsCount,
    required this.feedback,
  }) : aid = aid ?? uuid.v4();

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      aid: json['aid'] as String,
      questionId: json['questionId'] as String? ?? '',
      response: json['response'] as String,
      attempsCount: json['attempCount'] as int,
      feedback: FeedbackModel.fromJson(json['feedback']),
    );
  }
  Map<String, dynamic> toJson () {
    return {
      'aid': aid,
      'questionId': questionId,
      'response': response,
      'attempCount': attempsCount,
      'feedback': feedback.toJson(),
    };
  }
}
