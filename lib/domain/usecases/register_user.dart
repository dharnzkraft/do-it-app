import 'package:do_it_fixed_fixed/data/repositories/auth_repository.dart';
import 'package:do_it_fixed_fixed/domain/entities/user.dart';



class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<bool> call(User user) {
    return repository.register(user);
  }
}
