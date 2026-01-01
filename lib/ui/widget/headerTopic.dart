import 'package:flutter/material.dart';

class Headertopic extends StatelessWidget {
  const Headertopic({super.key, required this.title, required this.point});
  final String title;
  final int point;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      actions: [
        Row(
          children: [
            Icon(
              Icons.water_drop,
              color: Theme.of(context).colorScheme.primary,
              size: 20,
            ),
            SizedBox(width: 4),
            Text(
              point.toString(),
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(width: 16),
            // Icon(Icons.favorite, color: Colors.red, size: 20),
            // SizedBox(width: 4),
            // Text(
            //   '5',
            //   style: TextStyle(
            //     fontSize: 16,
            //     color: Theme.of(context).colorScheme.onSurface,
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
