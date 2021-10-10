
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:cleanarchitectureproject/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
 import 'package:cleanarchitectureproject/features/number_trivia/presentation/widgets/message_display.dart';
 import 'package:cleanarchitectureproject/features/number_trivia/presentation/widgets/trivia_controls.dart';
 import 'package:cleanarchitectureproject/features/number_trivia/presentation/widgets/loading_widget.dart';
 import '../../../../injection_container.dart';
import 'package:cleanarchitectureproject/features/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:cleanarchitectureproject/features/number_trivia/presentation/bloc/number_trivia_state.dart';
 class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

         home:   Scaffold(
     body: BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Top half
           BlocBuilder<NumberTriviaBloc,  NumberTriviaState >(
                builder: (context, state)
                {
                   if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
               return CircularProgressIndicator();
                }

              ),
              SizedBox(height: 20),
              // Bottom half
              TriviaControls()
            ],
          ),
        ),
      ),
    )));

}}