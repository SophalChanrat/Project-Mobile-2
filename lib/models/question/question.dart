import 'package:uuid/uuid.dart';

final uuid = Uuid();

abstract class Question {
  final String qid;
  final String title;

  Question({String? qid, required this.title})
    : qid = qid ?? uuid.v4();

  Map<String, dynamic> toBaseJson() {
    return {'qid': qid, 'title': title};
  }
}
