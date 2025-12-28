import 'package:app_mvp/models/feedback.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Answer {
  final String aid;
  final String response;
  final int attempsCount;
  final Feedback feedback;

  Answer({required this.response, required this.attempsCount, required this.feedback}) : aid = uuid.v4();

}