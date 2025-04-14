import 'dart:async';
import 'package:flutter/material.dart';
import '../models/question.dart';
import '../services/api_service.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String category;
  final String difficulty;

  QuizScreen({required this.category, required this.difficulty});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [];
  int _index = 0;
  int _score = 0;
  bool _answered = false;
  String _selected = "";
  String _feedback = "";
  Timer? _timer;
  int _timeLeft = 15;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _startTimer() {
    _timeLeft = 15;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timeLeft--;
        if (_timeLeft == 0) {
          _submitAnswer('');
        }
      });
    });
  }

  Future<void> _loadQuestions() async {
    final questions = await ApiService.fetchQuestions(widget.category, widget.difficulty);
    setState(() {
      _questions = questions;
    });
    _startTimer();
  }

  void _submitAnswer(String option) {
    _timer?.cancel();
    setState(() {
      _answered = true;
      _selected = option;
      final correct = _questions[_index].correctAnswer;
      if (option == correct) {
        _score++;
        _feedback = "✅ Correct!";
      } else {
        _feedback = "❌ Incorrect. Answer: $correct";
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _index++;
      _answered = false;
      _selected = '';
      _feedback = '';
    });
    if (_index < _questions.length) {
      _startTimer();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(score: _score, total: _questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final question = _questions[_index];
    return Scaffold(
      appBar: AppBar(title: Text("Quiz")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Text("Time Left: $_timeLeft s", style: TextStyle(fontSize: 16, color: Colors.red)),
          SizedBox(height: 10),
          Text("Question ${_index + 1}/${_questions.length}", style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text(question.question, style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          ...question.options.map((opt) => ElevatedButton(
                onPressed: _answered ? null : () => _submitAnswer(opt),
                child: Text(opt),
              )),
          if (_answered) ...[
            SizedBox(height: 10),
            Text(_feedback),
            ElevatedButton(onPressed: _nextQuestion, child: Text("Next"))
          ]
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
