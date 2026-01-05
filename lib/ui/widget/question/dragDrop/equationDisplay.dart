import 'package:app_mvp/ui/widget/question/dragDrop/dropTarget.dart';
import 'package:app_mvp/ui/widget/question/dragDrop/termBox.dart';
import 'package:flutter/material.dart';

class EquationDisplay extends StatelessWidget {
  final String equation;
  final Map<String, String?> droppedValues;
  final Function(String targetKey, String value) onAccept;

  const EquationDisplay({
    super.key,
    required this.equation,
    required this.droppedValues,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    final parts = equation.split(' ');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: parts.map((part) {
        // Check if this part is a placeholder like {slot1}, {slot2}
        if (part.startsWith('{') && part.endsWith('}')) {
          final targetKey = part.substring(1, part.length - 1);
          return DropTarget(
            targetKey: targetKey,
            droppedValue: droppedValues[targetKey],
            onAccept: onAccept,
          );
        } else if (_isOperator(part)) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              part,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return Termbox(value: part);
        }
      }).toList(),
    );
  }

  bool _isOperator(String value) => ['+', '-', '*', '/', '='].contains(value);
}
