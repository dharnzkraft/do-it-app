import '../entities/user.dart';

abstract class AuthRepository {
  Future<bool> register(User user);
  Future<bool> login(User user); 
}
