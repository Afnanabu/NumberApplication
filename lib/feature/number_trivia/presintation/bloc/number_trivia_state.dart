 import 'package:equatable/equatable.dart';
import 'package:numbertrivia/feature/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState([List props = const <dynamic>[]]);
}

class Empty extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class Loading extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;
  Loaded({required this.trivia});
  @override
  List<Object> get props => [Loaded(trivia: trivia)];
}

class Error extends NumberTriviaState {
  final String message;
  Error({required this.message});
  @override
  List<Object> get props => [Error(message: message)];
}
