import 'package:flutter/material.dart';

class Progressbar extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;
  final int totalAttempts;
  final VoidCallback? onClose;

  const Progressbar({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.totalAttempts,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalQuestions > 0 ? currentQuestion / totalQuestions : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          // Close button
          GestureDetector(
            onTap: onClose,
            child: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          // Progress bar
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 20,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Heart with attempts count
          Row(
            children: [
              const Icon(
                Icons.favorite,
                color: Color(0xFFFF5252),
                size: 24,
              ),
              const SizedBox(width: 4),
              Text(
                '$totalAttempts',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}