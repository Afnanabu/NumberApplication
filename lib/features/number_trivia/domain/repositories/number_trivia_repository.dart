import 'package:dartz/dartz.dart';

 import '../entities/number_trivia.dart';
import 'package:cleanarchitectureproject/core/error/errors.dart';
abstract class NumberTriviaRepository {
 Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
 Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}