import 'package:app_mvp/models/question/question.dart';
import 'package:app_mvp/models/question/questionType.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Lesson {
  final String lessonId;
  final String lessonName;
  final int maxAttempts;
  final int point;
  final List<Question> questions;

  Lesson({
    String? lessonId,
    required this.lessonName,
    required this.maxAttempts,
    required this.point,
    required this.questions,
  }) : lessonId = lessonId ?? uuid.v4();

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      lessonId: json['lessonId'] as String,
      lessonName: json['lessonName'] as String,
      maxAttempts: json['maxAttemps'] as int,
      point: json['point'] as int,
      questions: (json['questions'] as List)
          .map((question) => QuestionType.fromJson(question))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'lessonId': lessonId,
      'lessonName': lessonName,
      'maxAttemps': maxAttempts,
      'point': point,
      'questions': questions.map((question) => question.toBaseJson()).toList(),
    };
  }
}
