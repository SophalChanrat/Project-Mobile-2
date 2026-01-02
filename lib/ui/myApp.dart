import 'package:app_mvp/models/player.dart';
import 'package:app_mvp/models/topic.dart';
import 'package:app_mvp/router/router.dart';
import 'package:flutter/material.dart';

class Myapp extends StatelessWidget {
  const Myapp({
    super.key,
    required this.topics,
    required this.player,
    required this.isFirstTime,
  });
  final List<Topic> topics;
  final bool isFirstTime;
  final Player? player;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tork Tork',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Fredoka',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3DC6F9),
          primary: const Color(0xFF3DC6F9),
          surface: Colors.white,
          onSurface: Color(0xFF1F2933),
        ),
      ),
      routerConfig: router(
        isFirstTime: isFirstTime,
        topics: topics,
        player: player,
      ),
    );
  }
}
