import 'package:cleanarchitectureproject/core/error/failures.dart';
import 'package:cleanarchitectureproject/core/usecase/usecase.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
  class GetConcreteNumberTrivia implements  UseCase<NumberTrivia,int > {
  final NumberTriviaRepository repository;
  GetConcreteNumberTrivia(this.repository);
  @override
  Future<Either<Errors, NumberTrivia>>call( int params  )  async {return await repository.getConcreteNumberTrivia(params);
  }
   }

class Params extends Equatable {
  final int number;

  Params({required this.number});

  @override
  List<Object> get props => [number];
}