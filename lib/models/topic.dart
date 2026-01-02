import 'package:app_mvp/models/lesson.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Topic {
  final String topicId;
  final String topicName;
  final double progressPercentage;
  final List<Lesson> lessons;

  Topic({
    String? topicId,
    required this.topicName,
    required this.progressPercentage,
    required this.lessons,
  }) : topicId = topicId ?? uuid.v4();

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      topicId: json['topicId'] as String,
      topicName: json['topicName'] as String,
      progressPercentage: json['progressPercentage'] as double? ?? 0.0 ,
      lessons: (json['lessons'] as List)
          .map((lesson) => Lesson.fromJson(lesson))
          .toList(),
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'topicId': topicId,
      'topicName': topicName,
      'progressPercentage': progressPercentage,
      'lessons': lessons.map((lesson) => lesson.toJson()).toList()
    };
  }
}
