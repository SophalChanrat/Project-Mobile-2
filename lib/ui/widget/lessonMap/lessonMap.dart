import 'package:app_mvp/data/userRepository.dart';
import 'package:app_mvp/models/lesson.dart';
import 'package:app_mvp/router/AppRouter.dart';
import 'package:app_mvp/ui/widget/lessonMap/lessonButton.dart';
import 'package:app_mvp/ui/widget/lessonMap/infoLessonBox.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LessonMap extends StatefulWidget {
  const LessonMap({super.key, required this.lessons});
  final List<Lesson> lessons;

  @override
  State<LessonMap> createState() => _LessonMapState();
}

class _LessonMapState extends State<LessonMap> {
  int? selectedLessonIndex;
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

  /// A lesson is unlocked if it's the first lesson OR the previous lesson is completed
  bool _isLessonLocked(int index) {
    if (index == 0) return false; // First lesson is always unlocked
    final previousLesson = widget.lessons[index - 1];
    return !completedLessonIds.contains(previousLesson.lessonId);
  }

  /// Check if a lesson is completed
  bool _isLessonCompleted(int index) {
    final lesson = widget.lessons[index];
    return completedLessonIds.contains(lesson.lessonId);
  }

  void _onLessonTap(int index) {
    setState(() {
      selectedLessonIndex = selectedLessonIndex == index ? null : index;
    });
  }

  void _startLesson(Lesson lesson) async {
    await context.push(AppRouter.questionScreen, extra: lesson);
    // Reload completed lessons when returning from question screen
    if (mounted) {
      await _loadCompletedLessons();
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
    // Creates a zigzag pattern: center -> left -> center -> right -> repeat
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
