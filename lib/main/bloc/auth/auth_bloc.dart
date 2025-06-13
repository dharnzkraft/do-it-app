import 'dart:convert';

import 'package:do_it_fixed_fixed/domain/entities/user.dart';
import 'package:do_it_fixed_fixed/domain/usecases/login_user.dart';
import 'package:do_it_fixed_fixed/domain/usecases/register_user.dart';
import 'package:do_it_fixed_fixed/main/bloc/auth/auth_event.dart';
import 'package:do_it_fixed_fixed/main/bloc/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;

    final _secureStorage = const FlutterSecureStorage();
  final _localAuth = LocalAuthentication();

  AuthBloc({required this.loginUser, required this.registerUser})
    : super(AuthInitial()) {
    on<LoginRequested>(_onLogin);
    // on<LoginRequested>(_onBiometricLogin as EventHandler<LoginRequested, AuthState>);
    on<RegisterRequested>(_onRegister);
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
  emit(AuthLoading());

  final success = await loginUser(
    User(email: event.email, password: event.password),
  );

  if (success) {
    await _secureStorage.write(key: 'email', value: event.email);
    await _secureStorage.write(key: 'password', value: event.password);

    final prefs = await SharedPreferences.getInstance();

    final usersString = prefs.getString('users');
    if (usersString != null) {
      final users = List<Map<String, dynamic>>.from(jsonDecode(usersString));

      final user = users.firstWhere(
        (u) => u['email'] == event.email,
        orElse: () => {},
      );

      if (user.isNotEmpty) {
        await prefs.setString('logged_in_user', jsonEncode(user));
      }
    }

    emit(AuthSuccess());
  } else {
    emit(AuthFailure("Invalid credentials"));
  }
}


  Future<void> _onRegister(
  RegisterRequested event,
  Emitter<AuthState> emit,
) async {
  emit(AuthLoading());
  final result = await registerUser(
    User(
      email: event.email,
      password: event.password,
      name: event.name,
      mobile: event.mobile,
    ),
  );

  if (result) {
    final prefs = await SharedPreferences.getInstance();

    final rawUsers = prefs.get('users');

    List<Map<String, dynamic>> users = [];
    if (rawUsers is String) {
      users = List<Map<String, dynamic>>.from(jsonDecode(rawUsers));
    } else if (rawUsers != null) {
      await prefs.remove('users');
    }

    final existingUser = users.any((user) => user['email'] == event.email);
    if (existingUser) {
      emit(AuthFailure("User already exists"));
      return;
    }
    final newUser = {
      'name': event.name,
      'email': event.email,
      'password': event.password,
      'mobile': event.mobile,
    };
    users.add(newUser);

    await prefs.setString('users', jsonEncode(users));

    await prefs.setString('logged_in_user', jsonEncode({
      'name': event.name,
      'email': event.email,
      'mobile': event.mobile,
    }));

    emit(AuthSuccess());
  } else {
    emit(AuthFailure("User already exists"));
  }
}



  Future<void> _onBiometricLogin(BiometricLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isSupported = await _localAuth.isDeviceSupported();

      if (!canCheck || !isSupported) {
        emit(AuthFailure("Biometric authentication is not available"));
        return;
      }

      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Use your fingerprint or face to log in',
        options: const AuthenticationOptions(biometricOnly: true),
      );

      if (authenticated) {
        final email = await _secureStorage.read(key: 'email');
        final password = await _secureStorage.read(key: 'password');

        if (email != null && password != null) {
          final success = await loginUser(User(email: email, password: password));
          if (success) {
            emit(AuthSuccess());
          } else {
            emit(AuthFailure("Stored credentials are invalid"));
          }
        } else {
          emit(AuthFailure("No stored credentials found"));
        }
      } else {
        emit(AuthFailure("Biometric authentication failed"));
      }
    } catch (e) {
      emit(AuthFailure("Error: ${e.toString()}"));
    }
  }


  
}
