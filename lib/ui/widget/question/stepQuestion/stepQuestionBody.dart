import 'package:app_mvp/models/question/stepByStepQuestion.dart';
import 'package:app_mvp/ui/widget/question/stepQuestion/questionText.dart';
import 'package:app_mvp/ui/widget/question/stepQuestion/stepQuestion.dart';
import 'package:flutter/material.dart';

class StepQuestionBody extends StatelessWidget {
  const StepQuestionBody({
    super.key,
    required this.question,
    required this.selectedSteps,
    required this.onStepTap,
  });

  final StepByStepQuestion question;
  final List<String> selectedSteps;
  final Function(String) onStepTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 24),
          QuestionText(equation: question.content),
          const SizedBox(height: 32),
          ...question.steps.map((step) {
            return Column(
              children: [
                Center(
                  child: StepQuestionBox(
                    text: step,
                    isSelected: selectedSteps.contains(step),
                    onTap: () => onStepTap(step),
                  ),
                ),
                SizedBox(height: 20),
              ],
            );
          }),
        ],
      ),
    );
  }
}