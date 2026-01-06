import 'package:app_mvp/models/submission.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Player {
  final String playerId;
  final Duration preferTimeSpend;
  final List<Submission> submissions;
  final int totalPoints;

  Player ({
    String? playerId,
    required this.preferTimeSpend,
    required this.submissions,
    required this.totalPoints,
  }) : playerId = playerId ?? uuid.v4();

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      playerId: json['playerId'] as String,
      preferTimeSpend:
          Duration(minutes: json['preferTimeSpend'] as int),
      submissions: (json['submissions'] as List)
          .map((submission) => Submission.fromJson(submission))
          .toList(),
      totalPoints: (json['totalPoints'] as int?) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'playerId': playerId,
      'preferTimeSpend': preferTimeSpend.inMinutes,
      'submissions': submissions.map((submission) => submission.toJson()).toList(),
      'totalPoints': totalPoints,
    };
  }
}