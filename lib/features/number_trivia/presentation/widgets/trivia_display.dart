import 'package:flutter/material.dart';
 import 'package:cleanarchitectureproject/features/number_trivia/domain/entities/number_trivia.dart';
class TriviaDisplay extends StatelessWidget {
  final NumberTrivia numberTrivia;

  const TriviaDisplay({

    required this.numberTrivia,
  }) ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

     home: Column(
        children: <Widget>[
          Text(
            numberTrivia.number.toString(),
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
           Center(
              child: SingleChildScrollView(
                child: Text(
                numberTrivia.number.toString(),

                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

        ],
      ),
    );
  }
}