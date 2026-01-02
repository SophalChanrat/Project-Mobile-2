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
    return !(prefs.getBool(_isOpened) ?? false);
  }
  
  static Future<void> savePlayer(Player player) async {
    final prefs = await _instance;
    await prefs.setString(_playerKey, json.encode(player.toJson()));
  }

  static Future<Player?> loadPlayer() async {
    final prefs = await _instance;
    final jsonString = prefs.getString(_playerKey);
    if (jsonString == null) return null;
    return Player.fromJson(json.decode(jsonString));
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
    final player = await loadPlayer();
    if (player != null) {
      final updatedPlayer = Player(
        playerId: player.playerId,
        preferTimeSpend: player.preferTimeSpend,
        submissions: [...player.submissions, submission],
      );
      await savePlayer(updatedPlayer);
    }
  }
  static Future<void> clearAll() async {
    final prefs = await _instance;
    await prefs.clear();
  }

}