import 'package:app_mvp/ui/widget/question/stepQuestion/termBox.dart';
import 'package:flutter/material.dart';

class QuestionText extends StatelessWidget {
  final String equation;

  const QuestionText({super.key, required this.equation});

  @override
  Widget build(BuildContext context) {
    final parts = equation.split(' ');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: parts.map((part) {
        if (_isOperator(part)) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              part,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return TermBox(value: part);
        }
      }).toList(),
    );
  }

  bool _isOperator(String value) => ['+', '-', '*', '/', '='].contains(value);
}


