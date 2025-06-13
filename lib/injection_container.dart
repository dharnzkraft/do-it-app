import 'package:do_it_fixed_fixed/data/repositories/auth_repository.dart';
import 'package:do_it_fixed_fixed/domain/usecases/login_user.dart';
import 'package:do_it_fixed_fixed/domain/usecases/register_user.dart';
import 'package:do_it_fixed_fixed/main/bloc/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AuthBloc(
        loginUser: sl(),
        registerUser: sl(),
      ));

  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
}