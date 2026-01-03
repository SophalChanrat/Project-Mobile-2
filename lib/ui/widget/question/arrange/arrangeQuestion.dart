import 'package:flutter/material.dart';

class ArrangeQuestion extends StatelessWidget {
  final List<String> items;
  final ValueChanged<List<String>> onReorder;

  const ArrangeQuestion({
    super.key,
    required this.items,
    required this.onReorder,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      onReorder: (oldIndex, newIndex) {
        final updated = List<String>.from(items);
        if (newIndex > oldIndex) newIndex--;
        final item = updated.removeAt(oldIndex);
        updated.insert(newIndex, item);
        onReorder(updated);
      },
      itemBuilder: (context, index) {
        return Container(
          key: ValueKey(items[index]),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(width: 2, color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              ReorderableDragStartListener(
                index: index,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Icon(Icons.drag_handle, color: Colors.grey[600]),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    items[index],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}