import 'package:app_mvp/data/repository.dart';
import 'package:app_mvp/data/userRepository.dart';
import 'package:app_mvp/models/topic.dart';
import 'package:app_mvp/ui/myApp.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final List<Topic> data = await Repository.loadData();
  final bool isFirstTime = await UserRepository.getFirstOpen();
  runApp(Myapp(topics: data, isFirstTime: isFirstTime));
}
