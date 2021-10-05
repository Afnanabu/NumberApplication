import 'package:cleanarchitectureproject/features/number_trivia/data/models/number_trivia_models.dart';

abstract class NumberTriviaRemoteDataSource{
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel>   getRandoumNumberTrivia();
 }