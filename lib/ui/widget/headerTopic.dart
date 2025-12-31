import 'package:flutter/material.dart';

class Headertopic extends StatelessWidget {
  const Headertopic({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Math',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.water_drop,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
            SizedBox(width: 4),
            Text(
              '100',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(width: 16),
            Icon(
              Icons.favorite,
              color: Colors.red,
              size: 20,
            ),
            SizedBox(width: 4),
            Text(
              '5',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ],
    );
  }
}