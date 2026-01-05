import 'package:app_mvp/models/question/multipleChoice.dart';
import 'package:app_mvp/ui/widget/question/multipleChoices/choices.dart';
import 'package:flutter/material.dart';

class MultipleChoicesBody extends StatelessWidget {
  final MultipleChoice question;
  final int? selectedIndex;
  final Function(int) onChoiceSelected;

  const MultipleChoicesBody({
    super.key,
    required this.question,
    required this.selectedIndex,
    required this.onChoiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Choices(
            choices: question.choices,
            selectedIndex: selectedIndex,
            onChoiceSelected: onChoiceSelected,
          ),
        ),
      ],
    );
  }
}
