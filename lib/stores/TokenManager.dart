import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  // 初始化
  init() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', '123456');
  }

  setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}

final TokenManager tokenManager = TokenManager();
