import 'package:app_mvp/models/question/dragDropQuestion.dart';
import 'package:app_mvp/ui/widget/question/dragDrop/dragDropChoices.dart';
import 'package:app_mvp/ui/widget/question/dragDrop/dropTarget.dart';
import 'package:flutter/material.dart';

class DragDropBody extends StatelessWidget {
  final DragDropQuestion question;
  final String? selectedAnswer;
  final Function(String value) onAnswerSelected;

  const DragDropBody({
    super.key,
    required this.question,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Track if an answer has been selected
    final usedChoices = selectedAnswer != null ? {selectedAnswer!} : <String>{};

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
        const SizedBox(height: 32),
        Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(question.numberOfSlots, (index) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (index > 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '=',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (index > 0) const SizedBox(width: 10),
                    DropTarget(
                      targetKey: 'slot_$index',
                      droppedValue: selectedAnswer,
                      onAccept: (_, value) => onAnswerSelected(value),
                    ),
                  ],
                );
              }),
            ),
          ),
        const SizedBox(height: 40),
        Center(
          child: DragDropChoices(
            choices: question.draggableItem,
            usedChoices: usedChoices,
            selectedAnswer: selectedAnswer,
            onChoiceTap: onAnswerSelected,
          ),
        ),
      ],
    );
  }
}

