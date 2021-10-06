import 'package:cleanarchitectureproject/core/error/errors.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
class RandomeNumber  {
  final NumberTriviaRepository repository;
  RandomeNumber(this.repository);

Future<Either<Errors, NumberTrivia>> call() async {
  return await repository.getRandoumNumberTrivia();
}
}
