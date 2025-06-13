import 'package:do_it_fixed_fixed/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> registerUser(User user);
  Future<User?> loginUser(String username, String password);
}