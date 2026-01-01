import 'package:flutter/material.dart';

class LessonButton extends StatelessWidget {
  final int lessonNumber;
  final bool isLocked;
  final VoidCallback? onTap;

  const LessonButton({
    super.key,
    required this.lessonNumber,
    this.isLocked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isLocked
                    ? Colors.grey[300]
                    : Theme.of(context).colorScheme.primary,
              ),
            ),

            if (!isLocked)
              Icon(
                Icons.star,
                size: 35,
                color: Colors.white,
              ),

            if (isLocked)
              Icon(
                Icons.lock,
                size: 20,
                color: Colors.grey[600],
              ),
          ],
        ),
      ),
    );
  }
}