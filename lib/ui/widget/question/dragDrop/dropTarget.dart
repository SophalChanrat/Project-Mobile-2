import 'package:flutter/material.dart';

class DropTarget extends StatelessWidget {
  final String targetKey;
  final String? droppedValue;
  final Function(String targetKey, String value) onAccept;

  const DropTarget({
    super.key,
    required this.targetKey,
    required this.droppedValue,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAcceptWithDetails: (details) {
        onAccept(targetKey, details.data);
      },
      builder: (context, candidateData, rejectedData) {
        final isHovering = candidateData.isNotEmpty;
        
        return Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            color: droppedValue != null 
                ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                : Colors.white,
            border: Border.all(
              color: isHovering 
                  ? Theme.of(context).colorScheme.primary 
                  : Colors.grey.shade400,
              width: isHovering ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: droppedValue != null
                ? Text(
                    droppedValue!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : Text(
                    '_',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
