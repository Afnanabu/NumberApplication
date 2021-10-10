import 'package:cleanarchitectureproject/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
 import 'package:cleanarchitectureproject/features/number_trivia/domain/repositories/number_trivia_repository.dart';
 import 'package:cleanarchitectureproject/core/error/errors.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/entities/number_trivia.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}