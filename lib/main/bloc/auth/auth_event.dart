abstract class AuthEvent {}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String mobile;
  RegisterRequested({required this.email, required this.password, required this.mobile, required this.name});
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested({required this.email, required this.password});
}

class BiometricLoginRequested extends AuthEvent {}