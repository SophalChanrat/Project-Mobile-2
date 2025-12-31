import 'package:app_mvp/ui/screens/chooseTimeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
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
      home: Scaffold(body: Choosetimescreen()),
    ),
  );
}
