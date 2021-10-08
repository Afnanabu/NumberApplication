import 'package:get_it/get_it.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
 import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/util/input_converter.dart';
    import 'package:numbertrivia/feature/number_trivia/presintation/bloc/number_trivia_bloc.dart';
import 'package:numbertrivia/feature/number_trivia/domain/usecase/get_random_number_trivia.dart';
import 'package:numbertrivia/feature/number_trivia/domain/usecase/get_concrete_number_trivia.dart';
import 'package:numbertrivia/feature/number_trivia/domain/repositories/number_trivia_repositories.dart';
 import 'package:numbertrivia/feature/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:numbertrivia/feature/number_trivia/data/datasource/number_trivia_remote_data_source.dart';

import 'feature/number_trivia/data/repositore/number_trivia_repository_impl.dart';
final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
 /* sl.registerFactory(
        () => NumberTriviaBloc(
      concrete: sl(),
      inputConverter: sl(),
      random: sl(),
    ),
  );*/

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