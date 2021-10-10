import 'package:get_it/get_it.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cleanarchitectureproject/core/network/network_information.dart';
import 'package:cleanarchitectureproject/core/util/inpute_converte.dart';
 import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_ramdome_number_trivia.dart';
 import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
 import 'features/number_trivia/data/datasource/number_trivia_local_datasource.dart';
 import 'features/number_trivia/data/datasource/number_trivia_remote_datasource.dart ';
 import 'package:cleanarchitectureproject/features/number_trivia/data/repositories/number_triva_repositore_imp.dart';

import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
 final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
        () => NumberTriviaBloc(
      concrete: sl(),
      inputConverter: sl(),
      random: sl(), getConcreteNumberTrivia:sl(),
          getRandomNumberTrivia:sl (),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
        () =>  NumberTriviaRepositoryImplementaion(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
        () => NumberTriviaRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
        () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}