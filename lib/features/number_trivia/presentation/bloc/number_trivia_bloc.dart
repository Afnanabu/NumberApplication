import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cleanarchitectureproject/core/error/errors.dart';
import 'package:cleanarchitectureproject/core/util/inpute_converte.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:cleanarchitectureproject/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
 import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
part 'number_trivia_event.dart';
part 'number_trivia_state.dart';
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input - The number must be a positive integer or zero.';

 class NumberTriviaBlock extends Bloc<NumberTriviaEvent,NumberTriviaState> {
   final GetConcreteNumberTrivia getConcreteNumberTrivia;
   final GetRandomNumber getRandomNumberTrivia;
   final InputConverter inputConverter;

   NumberTriviaBlock({
     required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
      required this.inputConverter}) : super(IsEmpty());


   Stream<NumberTriviaState> mapEventToState(NumberTriviaEvent event,) async* {
     if (event is GetTriviaForConcreteNumber) {
       final inputEither =
       inputConverter.stringToUnsignedInteger(event.numberString);
       yield* inputEither.fold(
             (failure) async* {
           yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
         },
             (integer) async* {
               yield Loading();
               final failureOrTrivia = await getConcreteNumberTrivia(
                   Params(number: integer));
               yield* _eitherLoadedOrErrorState(failureOrTrivia);

             } );}
     else if (event is GetRandomNumber) {
       yield Loading();
       final failureOrTrivia = await getRandomNumberTrivia;

     }
   }

   Stream<NumberTriviaState> _eitherLoadedOrErrorState(
       Either<Errors, NumberTrivia> failureOrTrivia,) async* {
     yield failureOrTrivia.fold(
           (failure) => Error(message: _mapFailureToMessage(failure)),
           (trivia) => IsLoading(trivia),
     );
   }

   String _mapFailureToMessage(Errors errors) {
     switch (errors.runtimeType) {
       case ServerErrors:
         return SERVER_FAILURE_MESSAGE;
       case CacheErrors:
         return CACHE_FAILURE_MESSAGE;
       default:
         return 'Unexpected error';
     }
   }
 }