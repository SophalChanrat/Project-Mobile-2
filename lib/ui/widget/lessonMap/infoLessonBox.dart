import 'package:app_mvp/models/lesson.dart';
import 'package:flutter/material.dart';

class Infolessonbox extends StatelessWidget {
  final Lesson lesson;
  final int lessonNumber;
  final int totalLessons;
  final bool isLocked;
  final VoidCallback? onStart;

  const Infolessonbox({
    super.key,
    required this.lesson,
    required this.lessonNumber,
    required this.totalLessons,
    this.isLocked = false,
    this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isLocked
            ? Colors.grey[300]!
            : Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              lesson.lessonName,
              style: TextStyle(
                color: isLocked
                    ? Colors.grey[600]
                    : Theme.of(context).colorScheme.onSurface,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${lesson.questions.length} Questions',
              style: TextStyle(
                color: isLocked
                    ? Colors.grey[500]
                    : Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Lesson $lessonNumber of $totalLessons',
              style: TextStyle(
                color: isLocked
                    ? Colors.grey[500]
                    : Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: onStart,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: isLocked ? Colors.grey[400] : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  isLocked ? 'Locked' : 'Start + ${lesson.point} Droplets',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isLocked
                        ? Colors.white
                        : Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
      ),
    );
  }
}
