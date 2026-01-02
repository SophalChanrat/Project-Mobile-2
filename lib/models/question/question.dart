import 'package:app_mvp/models/answer.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

abstract class Question {
  final String qid;
  final String title;
  final List<Answer> answers;

  Question({String? qid, required this.title, required this.answers})
    : qid = qid ?? uuid.v4();

  Map<String, dynamic> toBaseJson() {
    return {'qid': qid, 'title': title, 'answers': answers};
  }
}
