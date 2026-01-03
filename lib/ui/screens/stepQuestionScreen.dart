import 'package:app_mvp/models/question/stepByStepQuestion.dart';
import 'package:app_mvp/ui/widget/button.dart';
import 'package:app_mvp/ui/widget/question/stepQuestion/questionText.dart';
import 'package:app_mvp/ui/widget/question/stepQuestion/stepQuestion.dart';
import 'package:flutter/material.dart';

class StepQuestionScreen extends StatefulWidget {
  const StepQuestionScreen({super.key, required this.question});
  final StepByStepQuestion question;

  @override
  State<StepQuestionScreen> createState() => _StepQuestionScreenState();
}

class _StepQuestionScreenState extends State<StepQuestionScreen> {
  List<String> selectedSteps = [];

  void _onStepTap(String step) {
    setState(() {
      if (selectedSteps.contains(step)) {
        selectedSteps.remove(step);
      } else {
        selectedSteps.add(step);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Text(
                widget.question.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 24),

              QuestionText(equation: widget.question.content),
              const SizedBox(height: 32),

              ...widget.question.steps.map((q) {
                return Column(
                  children: [
                    Center(
                      child: StepQuestionBox(
                        text: q,
                        isSelected: selectedSteps.contains(q),
                        onTap: () => _onStepTap(q),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                );
              }),

              const Spacer(),

              Button(label: "Continue", action: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
