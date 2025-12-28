import 'package:app_mvp/models/question.dart';
import 'package:app_mvp/models/submission.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Lesson {
  final String lessonId;
  final String lessonName;
  final int maxAttemps;
  final int point;
  final List<Submission> submissions;
  final List<Question> questions;

  Lesson({
    required this.lessonName,
    required this.maxAttemps,
    required this.point,
    required this.submissions,
    required this.questions
  }) : lessonId = uuid.v4();
}