import 'package:app_mvp/models/topic.dart';
import 'package:app_mvp/ui/widget/lessonMap/lessonMap.dart';
import 'package:flutter/material.dart';
import '../widget/lessonMap/topicBox.dart';
import '../widget/headerTopic.dart';

class LessonMapScreen extends StatefulWidget {
  const LessonMapScreen({super.key, required this.topic});
  final Topic topic;

  @override
  State<LessonMapScreen> createState() => _LessonMapScreenState();
}

class _LessonMapScreenState extends State<LessonMapScreen> {
  @override
  Widget build(BuildContext context) {
    final lessons = widget.topic.lessons;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            children: [
              Headertopic(title: "Math", point: 100),
              Padding(
                padding: const EdgeInsets.all(16),
              ),
              Topicbox(
                topicName: widget.topic.topicName,
                lessonNumber: 'Lessons: ${lessons.length}',
                lessonName: lessons.isNotEmpty ? lessons[0].lessonName : '',
              ),
              SizedBox(height: 20),
              LessonMap(lessons: lessons),
            ],
          ),
        ),
      ),
    );
  }
}
