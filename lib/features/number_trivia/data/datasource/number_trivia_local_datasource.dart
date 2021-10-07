import 'dart:convert';

import 'package:cleanarchitectureproject/core/error/exceptions.dart';
import 'package:cleanarchitectureproject/features/number_trivia/data/models/number_trivia_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {

  Future<NumberTriviaModel> getLastNumberTrivia();
  Future<void>cacheNumberTriva(NumberTriviaModel triviatoCache);
}
class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource{
  final   SharedPreferences   sharedPreferences;
  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> cacheNumberTriva(NumberTriviaModel triviatoCache) {
    return sharedPreferences.setString(
     ' CACHED_NUMBER_TRIVIA',
      json.encode(triviatoCache.toJson()),
    );
  }


  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString('CACHED_NUMBER_TRIVIA');
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheExcption();
    }
  }  }
  


