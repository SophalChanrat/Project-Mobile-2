import 'package:app_mvp/data/userRepository.dart';
import 'package:app_mvp/models/topic.dart';
import 'package:app_mvp/router/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopicCard extends StatefulWidget {
  const TopicCard({
    super.key,
    required this.topic,
    this.icon = Icons.emoji_events,
  });

  final Topic topic;
  final IconData icon;

  @override
  State<TopicCard> createState() => _TopicCardState();
}

class _TopicCardState extends State<TopicCard> {
  Set<String> completedLessonIds = {};

  @override
  void initState() {
    super.initState();
    _loadCompletedLessons();
  }

  Future<void> _loadCompletedLessons() async {
    final completed = await UserRepository.getCompletedLessonIds();
    if (mounted) {
      setState(() {
        completedLessonIds = completed;
      });
    }
  }

  /// Calculate progress based on completed lessons in this topic
  int get completedCount {
    return widget.topic.lessons
        .where((lesson) => completedLessonIds.contains(lesson.lessonId))
        .length;
  }

  double get percentage {
    if (widget.topic.lessons.isEmpty) return 0.0;
    return completedCount / widget.topic.lessons.length;
  }

  String get percentageText => "${(percentage * 100).round()} %";

  Color? get iconColor {
    if (percentage == 1.0) {
      return Colors.orange[200];
    }
    return Colors.grey[300];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: ListTile(
        onTap: () async {
          await context.push(AppRouter.lessonScreen, extra: widget.topic);
          // Reload progress when returning from lesson screen
          if (mounted) {
            await _loadCompletedLessons();
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15),
        ),
        tileColor: Colors.white,
        title: Text(
          widget.topic.topicName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
        ),
        subtitle: Padding(
          padding: EdgeInsets.all(10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: percentage,
                  minHeight: 20,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
                ),
              ),
              Text(
                percentageText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        trailing: Icon(Icons.emoji_events, color: iconColor),
      ),
    );
  }
}
