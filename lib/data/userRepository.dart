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
      // If old data doesn't have lessonId, clear and return null
      print('Error loading player: $e');
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
    
    // If no player exists, create a default one
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
    print('Submission saved for lesson: ${submission.lessonId}');
  }
  static Future<void> clearAll() async {
    final prefs = await _instance;
    await prefs.clear();
  }

  /// Check if a lesson has been completed (has at least one complete submission)
  static Future<bool> isLessonCompleted(String lessonId) async {
    final player = await loadPlayer();
    if (player == null) return false;
    return player.submissions.any(
      (s) => s.lessonId == lessonId && s.isComplete,
    );
  }

  /// Get all completed lesson IDs
  static Future<Set<String>> getCompletedLessonIds() async {
    final player = await loadPlayer();
    if (player == null) {
      print('getCompletedLessonIds: No player found');
      return {};
    }
    final completed = player.submissions
        .where((s) => s.isComplete)
        .map((s) => s.lessonId)
        .toSet();
    print('getCompletedLessonIds: Found ${completed.length} completed lessons: $completed');
    return completed;
  }

  /// Get submissions for a specific lesson
  static Future<List<Submission>> getSubmissionsForLesson(String lessonId) async {
    final player = await loadPlayer();
    if (player == null) return [];
    return player.submissions.where((s) => s.lessonId == lessonId).toList();
  }
}