import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultScreen({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz Finished")),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("You scored $score / $total", style: TextStyle(fontSize: 22)),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text("Play Again"),
            onPressed: () => Navigator.pop(context),
          )
        ]),
      ),
    );
  }
}
