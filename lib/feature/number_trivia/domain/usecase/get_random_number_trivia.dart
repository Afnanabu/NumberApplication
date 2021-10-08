import 'package:dartz/dartz.dart';
 import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/core/usecases/use_case.dart';
import 'package:numbertrivia/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:numbertrivia/feature/number_trivia/domain/repositories/number_trivia_repositories.dart';
class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}
