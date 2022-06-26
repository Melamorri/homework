import 'package:shared_preferences/shared_preferences.dart';
import 'package:week9/shared_prefs/user.dart';

const _emailKey = '_emailKey';
const _passwordKey = '_passwordKey';

class UserRepository {
  SharedPreferences? _sharedPreferences;

  Future<void> signUp(User user) async {
    await _initSharedPrefs();
    await _sharedPreferences?.setString(_emailKey, user.email);
    await _sharedPreferences?.setString(_passwordKey, user.password);
  }

  Future<bool> contains(User user) async {
    await _initSharedPrefs();
    final savedEmail = _sharedPreferences?.getString(_emailKey);
    final savedPassword = _sharedPreferences?.getString(_passwordKey);
    return user.email == savedEmail && user.password == savedPassword;
  }

  Future<void> _initSharedPrefs() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }
}
