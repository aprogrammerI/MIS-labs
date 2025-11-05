
import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../widgets/info_row.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  String _two(int n) => n.toString().padLeft(2, '0');

  String _formatDate(DateTime dt) => '${_two(dt.day)}.${_two(dt.month)}.${dt.year}';
  String _formatTime(DateTime dt) => '${_two(dt.hour)}:${_two(dt.minute)}';

  String _formatRemaining(Duration diff) {

    final days = diff.inDays.abs();
    final hours = diff.inHours.abs() - days * 24;
    return '${days} days, ${hours} hours';
  }

  @override
  Widget build(BuildContext context) {
    final exam = ModalRoute.of(context)!.settings.arguments as Exam;
    final now = DateTime.now();
    final diff = exam.dateTime.difference(now);

    final bool isPast = diff.isNegative;
    final Duration until = isPast ? now.difference(exam.dateTime) : diff;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: isPast ? Colors.grey.shade700 : Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exam.subject,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),


            InfoRow(
              icon: Icons.calendar_today,
              label: 'Date',
              value: '${_formatDate(exam.dateTime)}  •  ${_formatTime(exam.dateTime)}',
            ),
            const SizedBox(height: 8),


            InfoRow(
              icon: Icons.location_on,
              label: 'Classroom/s',
              value: exam.rooms.join(', '),
            ),
            const SizedBox(height: 16),


            Text(
              isPast
                  ? 'The exam has passed(time overdue by: ${_formatRemaining(until)})'
                  : 'Remaining: ${_formatRemaining(until)}',
              style: TextStyle(
                fontSize: 16,
                color: isPast ? Colors.red.shade700 : Colors.green.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
