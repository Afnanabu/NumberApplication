part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  List prpperties =const <dynamic>[];
  NumberTriviaEvent([prpperties]);
  List<Object?> get props=>[prpperties];
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  final String numberString;

  GetTriviaForConcreteNumber(this.numberString) ;
  @override
  List<Object>get props=>[numberString];


}

class GetRandomNumber extends NumberTriviaEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}