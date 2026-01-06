import 'package:app_mvp/models/lesson.dart';
import 'package:app_mvp/router/AppRouter.dart';
import 'package:app_mvp/ui/widget/lessonMap/lessonButton.dart';
import 'package:app_mvp/ui/widget/lessonMap/infoLessonBox.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LessonMap extends StatefulWidget {
  const LessonMap({
    super.key,
    required this.lessons,
    required this.completedLessonIds,
    this.onPointsEarned,
    this.onLessonComplete,
  });
  
  final List<Lesson> lessons;
  final Set<String> completedLessonIds;
  final void Function(int points)? onPointsEarned;
  final VoidCallback? onLessonComplete;

  @override
  State<LessonMap> createState() => _LessonMapState();
}

class _LessonMapState extends State<LessonMap> {
  int? selectedLessonIndex;

  bool _isLessonLocked(int index) {
    if (index == 0) return false; 
    final previousLesson = widget.lessons[index - 1];
    return !widget.completedLessonIds.contains(previousLesson.lessonId);
  }

  bool _isLessonCompleted(int index) {
    final lesson = widget.lessons[index];
    return widget.completedLessonIds.contains(lesson.lessonId);
  }

  void _onLessonTap(int index) {
    setState(() {
      selectedLessonIndex = index;
    });
  }

  void _startLesson(Lesson lesson) async {
    final result = await context.push<int>(AppRouter.questionScreen, extra: lesson);
    if (mounted) {
      widget.onLessonComplete?.call();
      if (result != null && result > 0) {
        widget.onPointsEarned?.call(result);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: List.generate(widget.lessons.length, (index) {
              final lesson = widget.lessons[index];
              final isLocked = _isLessonLocked(index);
              final isCompleted = _isLessonCompleted(index);
              final alignment = _getAlignment(index);

              return Column(
                children: [
                  Align(
                    alignment: alignment,
                    child: LessonButton(
                      lessonNumber: index + 1,
                      isLocked: isLocked,
                      isCompleted: isCompleted,
                      onTap: () => _onLessonTap(index),
                    ),
                  ),
                  SizedBox(height: 10),
                  if (selectedLessonIndex == index)
                    Align(
                      alignment: alignment,
                      child: Infolessonbox(
                        lesson: lesson,
                        lessonNumber: index + 1,
                        totalLessons: widget.lessons.length,
                        isLocked: isLocked,
                        onStart: isLocked ? null : () => _startLesson(lesson),
                      ),
                    ),
                  SizedBox(height: 20),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Alignment _getAlignment(int index) {
    switch (index % 4) {
      case 0:
        return Alignment.center;
      case 1:
        return Alignment.centerLeft;
      case 2:
        return Alignment.center;
      case 3:
        return Alignment.centerRight;
      default:
        return Alignment.center;
    }
  }
}
