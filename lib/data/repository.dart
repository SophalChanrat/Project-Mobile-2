import 'dart:convert';

import 'package:app_mvp/models/topic.dart';
import 'package:flutter/services.dart';

class Repository {
  static Future<List<Topic>> loadData() async {
    final String rawData = await rootBundle.loadString('assets/data/data.json');
    final Map<String, dynamic> data = json.decode(rawData);

    List<Topic> finalData = (data['topics'] as List)
        .map((topic) => Topic.fromJson(topic as Map<String, dynamic>))
        .toList();
    return finalData;
  }
}
