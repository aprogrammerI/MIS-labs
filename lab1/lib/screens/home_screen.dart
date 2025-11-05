import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../widgets/exam_card.dart';
import '../widgets/count_badge.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Exam> _examsRaw = [
    Exam(subject: 'Calculous', dateTime: DateTime(2025, 11, 04, 09, 00), rooms: ['lab 1']),
    Exam(subject: 'Structural Programming', dateTime: DateTime(2025, 11, 06, 14, 00), rooms: ['lab 2']),
    Exam(subject: 'OOP Programming', dateTime: DateTime(2025, 11, 10, 10, 30), rooms: ['lab 3', 'lab 4']),
    Exam(subject: 'Wed Design', dateTime: DateTime(2025, 11, 12, 08, 00), rooms: ['lab 2']),
    Exam(subject: 'Advanced Programming', dateTime: DateTime(2025, 11, 01, 12, 00), rooms: ['lab 1']),
    Exam(subject: 'Video Game Programming', dateTime: DateTime(2025, 12, 02, 09, 00), rooms: ['lab 12']),
    Exam(subject: 'Artificial Intelligence', dateTime: DateTime(2025, 12, 10, 13, 00), rooms: ['lab 3']),
    Exam(subject: 'Integrated Systems', dateTime: DateTime(2025, 10, 28, 11, 00), rooms: ['lab 18']),
    Exam(subject: 'Visual Programming', dateTime: DateTime(2025, 11, 20, 15, 00), rooms: ['lab 5']),
    Exam(subject: 'Databases', dateTime: DateTime(2025, 11, 15, 09, 00), rooms: ['lab 13']),
    Exam(subject: 'Probability and statistics ', dateTime: DateTime(2025, 12, 20, 10, 00), rooms: ['lab 4']),
  ];

  late final List<Exam> _exams;

  @override
  void initState() {
    super.initState();

    _exams = List<Exam>.from(_examsRaw)
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _exams.length,
              itemBuilder: (context, index) {
                final exam = _exams[index];
                final bool isPast = exam.dateTime.isBefore(DateTime.now());
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ExamCard(
                    exam: exam,
                    isPast: isPast,
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: CountBadge(count: _exams.length),
          ),
        ],
      ),
    );
  }
}
