import 'package:flutter/material.dart';
import 'injection_container.dart'as di;
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
Future<void > main() async
 {
   WidgetsFlutterBinding.ensureInitialized();
    di.init();

   runApp(MyApp());}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
      home: NumberTriviaPage(),
    );
  }
}