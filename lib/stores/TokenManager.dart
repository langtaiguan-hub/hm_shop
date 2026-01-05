import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  // 初始化
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', '123456');
  }

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}

final TokenManager tokenManager = TokenManager();
