import 'package:app_mvp/models/topic.dart';
import 'package:app_mvp/ui/widget/headerTopic.dart';
import 'package:app_mvp/ui/widget/topicCard.dart';
import 'package:flutter/material.dart';

class Topicscreen extends StatelessWidget {
  const Topicscreen({super.key, required this.topics});
  final List<Topic> topics;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Headertopic(title: "Math", point: 100,),
              Expanded(
                child: ListView.builder(
                  itemCount: topics.length,
                  itemBuilder: (context, index) => TopicCard(
                    topicName: topics[index].topicName,
                    progressPercentage: topics[index].progressPercentage,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
