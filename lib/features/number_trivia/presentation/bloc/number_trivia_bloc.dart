import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
   import 'number_trivia_event.dart';
import 'number_trivia_state.dart';
import 'package:cleanarchitectureproject/core/usecase/usecase.dart';
import 'package:cleanarchitectureproject/core/error/errors.dart';
import 'package:cleanarchitectureproject/core/util/inpute_converte.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/usecases/get_ramdome_number_trivia.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_FAILURE_MESSAGE = 'Invalid Input- The number must be a positive integer or zero';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {

  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;


  NumberTriviaBloc({
    required GetConcreteNumberTrivia concrete,
    required GetRandomNumberTrivia random,
   required this.inputConverter,

    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    }) : super(Empty()){
    on<NumberTriviaEvent>((event, emit) async* {
      if(event is GetTriviaForConcreteNumber)
      {
        final inputEither =
        inputConverter.stringToUnsignedInteger(event.numberString);

        yield* inputEither.fold(
              (failure) async* {
            yield Error(message: INVALID_FAILURE_MESSAGE);
          },
              (integer) async* {
            yield Loading();
            final failureOrTrivia = await getConcreteNumberTrivia(
              Params(number: integer),
            );
            yield* _eitherLoadedOrErrorState(failureOrTrivia);
          },
        );
      }else if (event is GetTriviaForRandomNumber) {
        yield Loading();
        final failureOrTrivia = await getRandomNumberTrivia(
          NoParams(),
        );
        yield* _eitherLoadedOrErrorState(failureOrTrivia);
      }
    });
  }
}

Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Failure, NumberTrivia> either,) async* {
  yield either.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (trivia) => Loaded(trivia: trivia),
  );
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected Error';
  }
}