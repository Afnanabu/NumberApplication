
import 'package:cleanarchitectureproject/core/error/errors.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';

abstract  class NumberTriviaRepository {
 Future<Either<Errors,NumberTrivia>> getConcreteNumberTrivia(int number);
 Future<Either<Errors,NumberTrivia>>  getRandoumNumberTrivia();

}