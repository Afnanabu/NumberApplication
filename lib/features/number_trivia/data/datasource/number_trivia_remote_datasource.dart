import 'dart:convert';
import 'package:cleanarchitectureproject/core/error/exceptions.dart';
 import 'package:cleanarchitectureproject/features/number_trivia/data/models/number_trivia_models.dart';
import 'package:http/http.dart'as http;
  abstract class NumberTriviaRemoteDataSource
{

  Future <NumberTriviaModel> getConcreteNumberTrivia(int number);

  Future <NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number)=> _getTriviaFromUrl('http://numbersapi.com/$number');

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() => _getTriviaFromUrl('http://numbersapi.com/random');


  Future<NumberTriviaModel> _getTriviaFromUrl(String url) async {
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200)
      return NumberTriviaModel.fromJson(json.decode(response.body));

    throw ServerException();
  }
}