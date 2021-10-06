import 'package:equatable/equatable.dart';
   class NumberTrivia extends Equatable {
   final int number;
   final String text;

   NumberTrivia({required this.number, required this.text}):super();

  @override
  // TODO: implement props
  List<Object?> get props =>[NumberTrivia(number:number,text: text )];


 }