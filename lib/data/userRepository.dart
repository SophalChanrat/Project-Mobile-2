import 'dart:convert';

import 'package:app_mvp/models/player.dart';
import 'package:app_mvp/models/submission.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static SharedPreferences? _pref;

  static Future<SharedPreferences> get _instance async {
    _pref = await SharedPreferences.getInstance();
    return _pref!;
  }

  static const _isOpened = 'is_open';
  static const _playerKey = 'player';

  static Future<void> setNotFirstOpen() async{
    final prefs = await _instance;
    prefs.setBool(_isOpened, true);
  }
  static Future<bool> getFirstOpen() async{
    final prefs = await _instance;
    return (prefs.getBool(_isOpened) ?? false);
  }

  static Future<void> setPlayerPreferTime(Duration preferTime) async {
    Player? player = await loadPlayer();
    if (player == null) {
      player = Player(
        preferTimeSpend: preferTime,
        submissions: [],
      );
    } else {
      player = Player(
        playerId: player.playerId,
        preferTimeSpend: preferTime,
        submissions: player.submissions,
      );
    }
    
    await savePlayer(player);
  }

  static Future<Duration> getPlayerPreferTime() async {
    final player = await loadPlayer();
    return player?.preferTimeSpend ?? Duration(minutes: 5);
  }
  
  static Future<void> savePlayer(Player player) async {
    final prefs = await _instance;
    await prefs.setString(_playerKey, json.encode(player.toJson()));
  }

  static Future<Player?> loadPlayer() async {
    final prefs = await _instance;
    final jsonString = prefs.getString(_playerKey);
    if (jsonString == null) return null;
    try {
      return Player.fromJson(json.decode(jsonString));
    } catch (e) {
      return null;
    }
  }

  static Future<Player> createPlayer(Duration preferTimeSpend) async {
    final player = Player(
      preferTimeSpend: preferTimeSpend,
      submissions: [],
    );
    await savePlayer(player);
    await setNotFirstOpen();
    return player;
  }
  static Future<void> addSubmission(Submission submission) async {
    Player? player = await loadPlayer();
    
    if (player == null) {
      player = Player(
        preferTimeSpend: Duration(minutes: 15),
        submissions: [],
      );
    }
    
    final updatedPlayer = Player(
      playerId: player.playerId,
      preferTimeSpend: player.preferTimeSpend,
      submissions: [...player.submissions, submission],
    );
    await savePlayer(updatedPlayer);
  }
  static Future<void> clearAll() async {
    final prefs = await _instance;
    await prefs.clear();
  }

  static Future<bool> isLessonCompleted(String lessonId) async {
    final player = await loadPlayer();
    if (player == null) return false;
    return player.submissions.any(
      (s) => s.lessonId == lessonId && s.isComplete,
    );
  }

  static Future<Set<String>> getCompletedLessonIds() async {
    final player = await loadPlayer();
    if (player == null) {
      return {};
    }
    final completed = player.submissions
        .where((s) => s.isComplete)
        .map((s) => s.lessonId)
        .toSet();
    return completed;
  }

  static Future<List<Submission>> getSubmissionsForLesson(String lessonId) async {
    final player = await loadPlayer();
    if (player == null) return [];
    return player.submissions.where((s) => s.lessonId == lessonId).toList();
  }
}