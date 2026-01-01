import 'package:app_mvp/models/lesson.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Topic {
  final String topicId;
  final String topicName;
  final double progressPercentage;
  final List<Lesson> lessons;

  Topic({
    required this.topicName,
    required this.progressPercentage,
    required this.lessons,
  }) : topicId = uuid.v4();

}