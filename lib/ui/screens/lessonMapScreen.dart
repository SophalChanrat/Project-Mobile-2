import 'package:app_mvp/data/userRepository.dart';
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
  int totalPoints = 0;
  Set<String> completedLessonIds = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final player = await UserRepository.loadPlayer();
    final completed = await UserRepository.getCompletedLessonIds();
    if (mounted) {
      setState(() {
        totalPoints = player?.totalPoints ?? 0;
        completedLessonIds = completed;
      });
    }
  }

  void _onPointsEarned(int points) {
    setState(() {
      totalPoints += points;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lessons = widget.topic.lessons;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Headertopic(title: "Math", point: totalPoints),
              SizedBox(height: 20),
              Topicbox(
                topicName: widget.topic.topicName,
                lessonNumber: 'Lessons: ${lessons.length}',
                lessonName: lessons.isNotEmpty ? lessons[0].lessonName : '',
              ),
              SizedBox(height: 20),
              LessonMap(
                lessons: lessons,
                completedLessonIds: completedLessonIds,
                onPointsEarned: _onPointsEarned,
                onLessonComplete: _loadData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
