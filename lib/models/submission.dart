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
    required this.date,
    required this.progress,
    required this.isComplete,
    required this.answers,
  }) : submissionId = uuid.v4();
}