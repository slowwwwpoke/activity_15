import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = '9';
  String _selectedDifficulty = 'easy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Start Quiz")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: InputDecoration(labelText: "Select Category"),
            items: [
              DropdownMenuItem(value: '9', child: Text('General Knowledge')),
              DropdownMenuItem(value: '21', child: Text('Sports')),
              DropdownMenuItem(value: '17', child: Text('Science')),
            ],
            onChanged: (value) => setState(() => _selectedCategory = value!),
          ),
          DropdownButtonFormField<String>(
            value: _selectedDifficulty,
            decoration: InputDecoration(labelText: "Select Difficulty"),
            items: ['easy', 'medium', 'hard'].map((level) {
              return DropdownMenuItem(value: level, child: Text(level));
            }).toList(),
            onChanged: (value) => setState(() => _selectedDifficulty = value!),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text("Start Quiz"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuizScreen(
                    category: _selectedCategory,
                    difficulty: _selectedDifficulty,
                  ),
                ),
              );
            },
          )
        ]),
      ),
    );
  }
}
