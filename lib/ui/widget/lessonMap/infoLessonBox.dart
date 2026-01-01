import 'package:flutter/material.dart';

class Infolessonbox extends StatelessWidget {
  final String topicName;
  final int lessonNumber;
  final int totalLessons;
  final int point;
  final bool isLocked;
  const Infolessonbox({
    super.key,
    required this.topicName,
    required this.lessonNumber,
    required this.totalLessons,
    required this.point,
    this.isLocked = false,
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
              topicName,
              style: TextStyle(
                color: isLocked
                    ? Colors.grey[600]
                    : Theme.of(context).colorScheme.onSurface,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: isLocked ? Colors.grey[400] : Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                isLocked ? 'Locked' : 'Start + $point Droplets',
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
          ],
      ),
    );
  }
}
