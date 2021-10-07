part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  List properties=const <dynamic>[];
  NumberTriviaState([properties]);
  List<Object?>get props=>[properties];
}
class IsEmpty extends NumberTriviaState{}
class Loading extends NumberTriviaState{}
class IsLoading extends NumberTriviaState{
  final  NumberTrivia trivia;
  IsLoading(this.trivia);
  List<Object?>get props=>[trivia];
}
class Error extends NumberTriviaState{
  final String message;
  Error({required this.message});
  List <Object>get props=>[message];
}