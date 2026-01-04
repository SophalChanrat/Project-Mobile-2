import 'package:app_mvp/models/question/arrangeAnswersQuestion.dart';
import 'package:app_mvp/ui/widget/question/arrange/arrangeQuestion.dart';
import 'package:flutter/material.dart';

class ArrangeQuestionBody extends StatelessWidget {
  const ArrangeQuestionBody({
    super.key,
    required this.question,
    required this.currentOrder,
    required this.onReorder,
  });

  final ArrangeAnswersQuestion question;
  final List<String> currentOrder;
  final Function(List<String>) onReorder;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Expanded(
          child: ArrangeQuestion(
            items: currentOrder,
            onReorder: onReorder,
          ),
        ),
      ],
    );
  }
}