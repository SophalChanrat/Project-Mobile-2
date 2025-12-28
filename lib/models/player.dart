import 'package:app_mvp/models/submission.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Player {
  final String playerId;
  final Duration preferTimeSpend;
  final List<Submission> submissions;

  Player ({
    required this.preferTimeSpend,
    required this.submissions
  }) : playerId = uuid.v4();
}