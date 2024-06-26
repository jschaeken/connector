import 'package:connector/features/auth/data/datasources/auth_datasource.dart';
import 'package:connector/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:connector/features/auth/domain/entities/user.dart';
import 'package:connector/features/auth/domain/repositories/auth_repo.dart';
import 'package:connector/features/auth/domain/usecases/auth_state_chages_stream.dart';
import 'package:connector/features/auth/domain/usecases/get_current_user.dart';
import 'package:connector/features/auth/domain/usecases/login_with_email_and_password.dart';
import 'package:connector/features/auth/domain/usecases/logout_current_user.dart';
import 'package:connector/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final FirebaseAuth faInstance = FirebaseAuth.instance;
  sl.registerLazySingleton(() => faInstance);
  //! Features - Auth
  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      loginWithEmailAndPassword: sl(),
      logoutCurrentUser: sl(),
      authStateChanges: sl<Stream<ConnectorUser?>>(),
      getCurrentUser: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginWithEmailAndPassword(repo: sl()));
  sl.registerLazySingleton(() => AuthStateChagesStream(repo: sl()));
  sl.registerLazySingleton<Stream<ConnectorUser?>>(
      () => sl<AuthStateChagesStream>()());
  sl.registerLazySingleton(() => LogoutCurrentUser(repo: sl()));
  sl.registerLazySingleton(() => GetCurrentUser(repo: sl()));

  // Repository
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      dataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(
      instance: sl(),
    ),
  );

  //! Core

  //! External
}
