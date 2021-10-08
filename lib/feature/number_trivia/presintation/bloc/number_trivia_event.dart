
import 'package:equatable/equatable.dart';

abstract class NumberTriviaEvent extends Equatable {
  NumberTriviaEvent([List props = const <dynamic>[]]);
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent
{
  final String numberString;
  GetTriviaForConcreteNumber({required this.numberString});

  @override
  // TODO: implement props
  List<Object?> get props => [GetTriviaForConcreteNumber(numberString:numberString)];

}

class GetTriviaForRandomNumber extends NumberTriviaEvent
{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}