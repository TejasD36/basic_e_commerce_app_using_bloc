import 'package:hive_ce/hive_ce.dart';

class AuthLocalDataSource {
  static const _boxName = 'auth_box';
  static const _loggedInKey = 'is_logged_in';
  static const _emailKey = 'email';

  Future<Box> get _box async => await Hive.openBox(_boxName);

  Future<bool> isLoggedIn() async {
    final box = await _box;
    return box.get(_loggedInKey, defaultValue: false);
  }

  Future<void> saveLogin(String email) async {
    final box = await _box;
    await box.put(_loggedInKey, true);
    await box.put(_emailKey, email);
  }

  Future<void> logout() async {
    final box = await _box;
    await box.put(_loggedInKey, false);
    await box.delete(_emailKey);
  }

  Future<String?> getSavedEmail() async {
    final box = await _box;
    return box.get(_emailKey);
  }
}
