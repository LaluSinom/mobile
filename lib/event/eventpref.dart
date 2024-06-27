import 'dart:convert';
import 'package:mobile_semt3/model/user.dart';

import 'package:shared_preferences/shared_preferences.dart';

class EventPref {
  static Future<User?> getUser() async {
    User? user;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringUser = prefs.getString('user');
    if (stringUser != null) {
      Map<String, dynamic> mapUser = jsonDecode(stringUser);
      user = User.fromJson(mapUser);
    }
    return user;
  }

  // save user
  static Future<void> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringUser = jsonEncode(user.toJson());
    await prefs.setString('user', stringUser);
  }

  // delete user
  static Future<void> deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
