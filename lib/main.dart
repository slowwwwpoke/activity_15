import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      theme: _darkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Trivia Quiz"),
          actions: [
            IconButton(
              icon: Icon(_darkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => setState(() => _darkMode = !_darkMode),
            )
          ],
        ),
        body: HomeScreen(),
      ),
    );
  }
}
