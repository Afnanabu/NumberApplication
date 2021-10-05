
import 'package:cleanarchitectureproject/core/error/exceptions.dart';
import 'package:cleanarchitectureproject/core/error/errors.dart';
import 'package:cleanarchitectureproject/core/network/network_information.dart';
 import 'package:cleanarchitectureproject/features/number_trivia/data/datasource/number_trivia_local_datasource.dart';
import 'package:cleanarchitectureproject/features/number_trivia/data/datasource/number_trivia_remote_datasource.dart';
import 'package:cleanarchitectureproject/features/number_trivia/data/models/number_trivia_models.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:dartz/dartz.dart';
typedef Future<NumberTriviaModel> _ConcreteOrRandomChooser();
class NumberTriviaImp extends NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaImp(
      {required this.networkInfo, required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Errors, NumberTrivia>> getConcreteNumberTrivia(
      int number,) async {
    return await _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Errors, NumberTrivia>> getRandoumNumberTrivia() async {
    return await _getTrivia(() {
      return remoteDataSource.getRandoumNumberTrivia();
    });
  }

  Future<Either<Errors, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom,) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
       localDataSource.cacheNumberTriva(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerExcption {
        return Left(ServerErrors([]));
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheExcption {
        return Left(CacheErrors([]));
      }
    }
  }

}


