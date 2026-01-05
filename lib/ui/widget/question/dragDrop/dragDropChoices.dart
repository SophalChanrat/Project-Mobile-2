import 'package:flutter/material.dart';
import 'choiceBox.dart';

class DragDropChoices extends StatelessWidget {
  final List<String> choices;
  final Set<String> usedChoices;
  final String? selectedAnswer;
  final Function(String) onChoiceTap;

  const DragDropChoices({
    super.key,
    required this.choices,
    required this.usedChoices,
    required this.selectedAnswer,
    required this.onChoiceTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: choices.map((choice) {
        final isSelected = selectedAnswer == choice;
        
        return GestureDetector(
          onTap: () => onChoiceTap(choice),
          child: Draggable<String>(
            data: choice,
            dragAnchorStrategy: pointerDragAnchorStrategy,
            feedback: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  choice,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: Choicebox(choice: choice, isSelected: false),
            ),
            child: Choicebox(choice: choice, isSelected: isSelected),
          ),
        );
      }).toList(),
    );
  }
}
