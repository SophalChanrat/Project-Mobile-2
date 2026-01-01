import 'package:app_mvp/ui/widget/lessonMap/lessonMap.dart';
import 'package:flutter/material.dart';
import '../widget/lessonMap/topicBox.dart';
import '../widget/headerTopic.dart';

class LessonMapScreen extends StatefulWidget {
  const LessonMapScreen({super.key});

  @override
  State<LessonMapScreen> createState() => _LessonMapScreenState();
}

class _LessonMapScreenState extends State<LessonMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            children: [
              Headertopic(),
              Padding(padding: const EdgeInsets.all(16)),
              Topicbox(
                topicName: 'Algebra',
                lessonNumber: 'Lesson 1',
                lessonName: 'Basic Linear Equations',
              ),
              SizedBox(height: 20),
              LessonMap(),
            ],
          ),
        ),
      ),
    );
  }
}
