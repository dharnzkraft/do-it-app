import 'dart:convert';
import 'package:do_it_fixed_fixed/data/models/user_model.dart';
import 'package:do_it_fixed_fixed/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRepository {
  Future<bool> register(User user);
  Future<bool> login(User user);
}

class AuthRepositoryImpl implements AuthRepository {
  static const _userKey = 'users';

  @override
  Future<bool> register(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getStringList(_userKey) ?? [];

    final exists = usersJson.any((e) => UserModel.fromJson(json.decode(e)).email == user.email);
    if (exists) return false;

    usersJson.add(json.encode(UserModel(email: user.email, password: user.password, name: user.name, mobile: user.mobile).toJson()));
    await prefs.setStringList(_userKey, usersJson);
    return true;
  }

  @override
  Future<bool> login(User user) async {
  final prefs = await SharedPreferences.getInstance();
  final usersJson = prefs.getString('users');
  List<Map<String, dynamic>> users = [];

  if (usersJson != null) {
    users = List<Map<String, dynamic>>.from(jsonDecode(usersJson));
  }

  final foundUser = users.firstWhere(
    (u) => u['email'] == user.email && u['password'] == user.password,
    orElse: () => {},
  );

  return foundUser.isNotEmpty;
}

}
