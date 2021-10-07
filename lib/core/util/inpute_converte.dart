import 'package:cleanarchitectureproject/core/error/errors.dart';
import 'package:dartz/dartz.dart';
class InputConverter {
  Either<Errors, int> stringToUnsignedInteger(String str) {
    try{
      final integer=int.parse(str);
      if(integer<0)throw FormatException();
      return Right(integer);

    }on FormatException{
      return Left(InvalidInputFailure([]));
    }
    // TODO: Implement
  }
}

class InvalidInputFailure extends Errors {
  InvalidInputFailure(List proparites) : super(proparites);
}