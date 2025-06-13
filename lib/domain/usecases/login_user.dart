

import 'package:do_it_fixed_fixed/data/repositories/auth_repository.dart';

import '../entities/user.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<bool> call(User user) {
    return repository.login(user);
  }
}