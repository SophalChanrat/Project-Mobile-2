import 'package:flutter/material.dart';

/// Reusable box for both Step-by-step and Arrange questions
class StepQuestionBox extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const StepQuestionBox({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
          border: Border.all(
            width: 2,
            color: isSelected ? Theme.of(context).colorScheme.primary : Colors.black
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}


