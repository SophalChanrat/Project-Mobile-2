import 'package:flutter/material.dart';
import '../widget/topicBox.dart';
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
              Headertopic(title: "Math", point: 100,),
              Padding(
                padding: const EdgeInsets.all(16),
              ),
              Topicbox(
                topicName: 'Algebra',
                lessonNumber: 'Lesson 1',
                lessonName: 'Basic Linear Equations',
              ),
            ],
          ),
        ),
      ),
    );
  }
}