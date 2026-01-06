import 'package:app_mvp/data/userRepository.dart';
import 'package:app_mvp/models/lesson.dart';
import 'package:app_mvp/models/topic.dart';
import 'package:app_mvp/ui/widget/headerTopic.dart';
import 'package:app_mvp/ui/widget/topicCard.dart';
import 'package:flutter/material.dart';

class Topicscreen extends StatefulWidget {
  const Topicscreen({super.key, required this.topics});
  final List<Topic> topics;

  @override
  State<Topicscreen> createState() => _TopicscreenState();
}

class _TopicscreenState extends State<Topicscreen> {
  int totalPoints = 0;
  Set<String> completedLessonIds = {};
  bool isLoading = true;
  int maxQuestions = 0; 

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final player = await UserRepository.loadPlayer();
    final completed = await UserRepository.getCompletedLessonIds();
    final preferTime = await UserRepository.getPlayerPreferTime();
  
    if (mounted) {
      setState(() {
        totalPoints = player?.totalPoints ?? 0;
        completedLessonIds = completed;
        maxQuestions = preferTime.inMinutes;
        isLoading = false;
      });
    }
  }
  List<Topic> _filterTopics(
    List<Topic> topics,
    int maxQuestions,
  ) {
    return topics.map((topic) {
      final lessons = topic.lessons.map((lesson) {
        final questions = lesson.questions.length <= maxQuestions
            ? lesson.questions
            : lesson.questions.take(maxQuestions).toList();

        return Lesson(
          lessonId: lesson.lessonId,
          lessonName: lesson.lessonName,
          maxAttempts: lesson.maxAttempts,
          point: lesson.point,
          questions: questions,
        );
      }).toList();

      return Topic(
        topicId: topic.topicId,
        topicName: topic.topicName,
        progressPercentage: topic.progressPercentage,
        lessons: lessons,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final filteredTopics = _filterTopics(
      widget.topics,
      maxQuestions,
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Headertopic(title: "Math", point: totalPoints),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredTopics.length,
                  itemBuilder: (context, index) => TopicCard(
                    topic: filteredTopics[index],
                    completedLessonIds: completedLessonIds,
                    onReturn: _loadData,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
