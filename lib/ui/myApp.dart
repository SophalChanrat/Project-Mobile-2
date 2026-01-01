import 'package:app_mvp/router/router.dart';
import 'package:flutter/material.dart';


class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Fredoka',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3DC6F9),
          primary: const Color(0xFF3DC6F9),
          surface: Colors.white,
          onSurface: Color(0xFF1F2933)
        ),
      ),
      routerConfig: router,
    );
  }
}