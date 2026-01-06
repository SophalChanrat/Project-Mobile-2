import 'package:app_mvp/models/topic.dart';
import 'package:app_mvp/router/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({
    super.key,
    required this.topic,
    required this.completedLessonIds,
    this.icon = Icons.emoji_events,
    this.onReturn,
  });

  final Topic topic;
  final Set<String> completedLessonIds;
  final IconData icon;
  final VoidCallback? onReturn;

  int get completedCount {
    return topic.lessons
        .where((lesson) => completedLessonIds.contains(lesson.lessonId))
        .length;
  }

  double get percentage {
    if (topic.lessons.isEmpty) return 0.0;
    return completedCount / topic.lessons.length;
  }

  String get percentageText => "${(percentage * 100).round()} %";

  Color? get iconColor {
    if (percentage == 1.0) {
      return Colors.orange[200];
    }
    return Colors.grey[300];
  }

  void _goToLesson(BuildContext context) async {
    await context.push(AppRouter.lessonScreen, extra: topic);
    onReturn?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: ListTile(
        onTap: () => _goToLesson(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15),
        ),
        tileColor: Colors.white,
        title: Text(
          topic.topicName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface,
          ),
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
                  valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).colorScheme.primary,
                  ),
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
