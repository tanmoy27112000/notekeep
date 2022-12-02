import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:notekeep/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  AuthHelper._privateConstructor();
  static final AuthHelper _instance = AuthHelper._privateConstructor();
  static AuthHelper get instance => _instance;

  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static final account = Account(client);

  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('isLoggedIn', value);
  }

  loginEmailPassword(String email, String password) async {
    final SharedPreferences prefs = await _prefs;
    try {
      final models.Session response = await account.createEmailSession(
        email: email,
        password: password,
      );
      prefs.setString('session', response.clientCode);
      prefs.setString('email', email);
      prefs.setString('password', password);
      setLoggedIn(true);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
