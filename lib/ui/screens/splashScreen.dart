import 'package:app_mvp/data/sharePreference.dart';
import 'package:app_mvp/models/topic.dart';
import 'package:app_mvp/router/AppRouter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final List<Topic> mockTopics = [
  Topic(topicName: "Basics", progressPercentage: 10, lessons: []),
  Topic(topicName: "Greetings", progressPercentage: 0.7, lessons: [],),
  Topic(topicName: "Daily Conversation", progressPercentage: 0.2, lessons: [],),
  Topic(topicName: "Travel", progressPercentage: 0.0, lessons: [],),
];

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _checkAndNavigate();
  }

  Future<void> _checkAndNavigate() async {
    final bool isFirstOpen = await SharePreference.getFirstOpen();

    if (!mounted) return;
    if (isFirstOpen) {
      context.go(AppRouter.onBoardingScreen, extra: mockTopics);
    } else {
      context.go(AppRouter.topicScreen, extra: mockTopics);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.rocket_launch, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              'Tork Tork',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
