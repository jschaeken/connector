import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connector/features/auth/data/datasources/auth_datasource.dart';
import 'package:connector/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:connector/features/auth/domain/entities/user.dart';
import 'package:connector/features/auth/domain/repositories/auth_repo.dart';
import 'package:connector/features/auth/domain/usecases/auth_state_chages_stream.dart';
import 'package:connector/features/auth/domain/usecases/get_current_user.dart';
import 'package:connector/features/auth/domain/usecases/login_with_email_and_password.dart';
import 'package:connector/features/auth/domain/usecases/logout_current_user.dart';
import 'package:connector/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:connector/features/engage/data/datasources/engage_datasource.dart';
import 'package:connector/features/engage/data/repositories/engage_repo_impl.dart';
import 'package:connector/features/engage/domain/repositories/engage_repo.dart';
import 'package:connector/features/engage/domain/usecases/send_push_notification.dart';
import 'package:connector/features/engage/presentation/bloc/engage_bloc.dart';
import 'package:connector/features/storage/data/datasources/storage_datasource.dart';
import 'package:connector/features/storage/data/repositories/project_info_repo_impl.dart';
import 'package:connector/features/storage/domain/repositories/project_info_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External
  final FirebaseAuth faInstance = FirebaseAuth.instance;
  final FirebaseFirestore ffInstance = FirebaseFirestore.instance;
  final Client httpClient = Client();

  sl.registerLazySingleton(() => faInstance);
  sl.registerLazySingleton(() => ffInstance);
  sl.registerLazySingleton(() => httpClient);

  //! Features - Auth
  // Data sources
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(
      instance: faInstance,
    ),
  );

  // Repository
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      dataSource: sl<AuthDataSource>(),
      projectInfoRepo: sl<ProjectInfoRepo>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(
      () => LoginWithEmailAndPassword(repo: sl<AuthRepo>()));
  sl.registerLazySingleton(() => AuthStateChagesStream(repo: sl<AuthRepo>()));
  sl.registerLazySingleton<Stream<ConnectorUser?>>(
      () => sl<AuthStateChagesStream>()());
  sl.registerLazySingleton(() => LogoutCurrentUser(repo: sl<AuthRepo>()));
  sl.registerLazySingleton(() => GetCurrentUser(repo: sl<AuthRepo>()));

  // Bloc
  sl.registerFactory(
    () => AuthBloc(
      loginWithEmailAndPassword: sl<LoginWithEmailAndPassword>(),
      logoutCurrentUser: sl<LogoutCurrentUser>(),
      authStateChanges: sl<Stream<ConnectorUser?>>(),
      getCurrentUser: sl<GetCurrentUser>(),
    ),
  );

  //! Features - Engage
  // Data sources
  sl.registerLazySingleton<EngageDatasource>(
    () => EngageDatasourceImpl(
      client: httpClient,
    ),
  );

  // Repositories
  sl.registerLazySingleton<EngageRepo>(
    () => EngageRepoImpl(
      authRepo: sl<AuthRepo>(),
      datasource: sl<EngageDatasource>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SendPushNotification(repo: sl<EngageRepo>()));

  // Bloc
  sl.registerFactory(
    () => EngageBloc(
      sendPushNotification: sl<SendPushNotification>(),
    ),
  );

  //! Core
  // Data sources
  sl.registerLazySingleton<StorageDataSource>(
    () => StorageDataSourceImpl(
      instance: ffInstance,
    ),
  );

  // Repositories
  sl.registerLazySingleton<ProjectInfoRepo>(
    () => ProjectInfoRepoImpl(
      dataSource: sl<StorageDataSource>(),
    ),
  );
}
