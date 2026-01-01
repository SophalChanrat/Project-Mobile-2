import 'package:app_mvp/ui/widget/lessonMap/lessonButton.dart';
import 'package:app_mvp/ui/widget/lessonMap/infoLessonBox.dart';
import 'package:flutter/material.dart';

class LessonMap extends StatefulWidget {
  const LessonMap({super.key});

  @override
  State<LessonMap> createState() => _LessonMapState();
}

class _LessonMapState extends State<LessonMap> {
  int? selectedLesson;

  void _onLessonTap(int lessonNumber) {
    setState(() {
      selectedLesson =
          selectedLesson == lessonNumber ? null : lessonNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                children: [
                  LessonButton(
                    lessonNumber: 1,
                    isLocked: false,
                    onTap: () => _onLessonTap(1),
                  ),
                  SizedBox(height: 10),
                  if (selectedLesson == 1)
                    Infolessonbox(
                      topicName: 'Basic Linear Equations',
                      lessonNumber: 1,
                      totalLessons: 10,
                      point: 10,
                      isLocked: false,
                    ),
                  SizedBox(height: 20),
                ],
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: LessonButton(
                      lessonNumber: 2,
                      isLocked: true,
                      onTap: () => _onLessonTap(2),
                    ),
                  ),
                  SizedBox(height: 10),
                  if (selectedLesson == 2)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Infolessonbox(
                        topicName: 'Advanced Linear Equations',
                        lessonNumber: 2,
                        totalLessons: 10,
                        point: 15,
                        isLocked: true,
                      ),
                    ),
                  SizedBox(height: 20),
                ],
              ),
              Column(
                children: [
                    LessonButton(
                      lessonNumber: 3,
                      isLocked: true,
                      onTap: () => _onLessonTap(3),
                    ),
                  SizedBox(height: 10),
                  if (selectedLesson == 3)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Infolessonbox(
                        topicName: 'Quadratic Equations',
                        lessonNumber: 3,
                        totalLessons: 10,
                        point: 20,
                        isLocked: true,
                      ),
                    ),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
