import 'package:app_mvp/models/feedback.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Answer {
  final String aid;
  final String response;
  final int attempsCount;
  final Feedback feedback;

  Answer({
    String? aid,
    required this.response,
    required this.attempsCount,
    required this.feedback,
  }) : aid = aid ?? uuid.v4();

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      aid: json['aid'] as String,
      response: json['response'] as String,
      attempsCount: json['attempCount'] as int,
      feedback: Feedback.fromJson(json['feedback']),
    );
  }
  Map<String, dynamic> toJson () {
    return {
      'aid': aid,
      'response': response,
      'attempCount': attempsCount,
      'feedback': feedback
    };
  }
}
