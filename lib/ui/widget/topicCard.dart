import 'package:flutter/material.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({
    super.key,
    required this.topicName,
    required this.progressPercentage,
    required this.icon,
  });

  final String topicName;
  final double progressPercentage;
  final IconData icon;

  double get percentage => progressPercentage * 10 / 100;
  String get percentageText => "${progressPercentage * 100 / 10} %";
  Color? get iconColor {
    if (progressPercentage == 10) {
      return Colors.orange[200];
    }
    return Colors.grey[300];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15),
        ),
        tileColor: Colors.white,
        title: Text(
          topicName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
        ),
        subtitle: Padding(
          padding: EdgeInsets.all(10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: percentage,
                  minHeight: 20,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation(Colors.lightBlue),
                ),
              ),
              Text(
                percentageText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        trailing: Icon(Icons.emoji_events, color: iconColor),
      ),
    );
  }
}
