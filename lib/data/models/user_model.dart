import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.email, required super.password, required super.name, required super.mobile});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        password: json['password'],
        name: json['name'],
        mobile: json['mobile']
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'mobile': mobile
      };
}