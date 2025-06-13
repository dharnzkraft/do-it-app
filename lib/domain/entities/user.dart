class User {
  final String email;
  final String password;
  final String? name;
  final String? mobile;

  User({required this.email, required this.password,  this.name, this.mobile});
}