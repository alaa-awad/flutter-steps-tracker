import 'package:flutter_steps_tracker/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/domain/repositories/steps_tracker_repositories.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/domain/usecases/add_data_tracker_usecase.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/domain/usecases/add_user_history_usecase.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/domain/usecases/get_data_tracker_usecase.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/domain/usecases/get_rewards_usecase.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/domain/usecases/get_user_history_usecase.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/domain/usecases/update_data_tracker_usecase.dart';
import 'package:flutter_steps_tracker/features/steps_tracker/presentation/cubit/steps_tracker_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/auth/data/datasources/user_local_data_source.dart';
import '../features/auth/data/datasources/user_remote_data_source.dart';
import '../features/auth/data/repositories/user_repository_impl.dart';
import '../features/auth/domain/repositories/user_repository.dart';
import '../features/auth/domain/usecases/log_in_usecase.dart';
import '../features/auth/domain/usecases/sign_up_usecase.dart';
import '../features/auth/presentation/cubit/user_cubit.dart';
import '../features/steps_tracker/data/datasources/local_database.dart';
import '../features/steps_tracker/data/datasources/remote_database.dart';
import '../features/steps_tracker/data/repositories/steps_trackers_repository_impl.dart';
import 'network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  // cubit user
  sl.registerFactory(() => UserCubit(logIn: sl(), signUp: sl(), logOut: sl()));

  // cubit Steps tracker
  sl.registerFactory(() => StepsTrackerCubit(
      addDataSteps: sl(),
      addHistory: sl(),
      getDataSteps: sl(),
      getRewards: sl(),
      getHistory: sl(),
      updateDataTracker: sl()));

  // UseCase user
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => LogInUseCase(sl()));
  sl.registerLazySingleton(() => LogOutUseCase(sl()));

  // UseCase steps trackers
  sl.registerLazySingleton(() => AddDataStepsTrackerUseCase(sl()));
  sl.registerLazySingleton(() => UpdateDataTrackerUseCase(sl()));
  sl.registerLazySingleton(() => GetDataStepsTrackerUseCase(sl()));
  sl.registerLazySingleton(() => GetRewardsUseCase(sl()));
  sl.registerLazySingleton(() => GetUserHistoryUseCase(sl()));
  sl.registerLazySingleton(() => AddHistoryStepsTrackerUseCase(sl()));


  // Repository user
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Repository StepsTrackers
  sl.registerLazySingleton<StepsTrackerRepository>(() => StepsTrackerRepositoryImpl(remoteDataBase: sl(), networkInfo: sl(), localDataBase: sl()));

  // DataSources user
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceFromFireBase());
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceWithDio());

  // DataSources steps trackers
  sl.registerLazySingleton<StepsRemoteDataBase>(
          () => StepsRemoteDataBaseFromFirebase());
  sl.registerLazySingleton<StepsLocalDataBase>(
          () => StepsLocalDataBaseImpl());


//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
