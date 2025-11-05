import 'package:flutter/material.dart';
import '../models/exam.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;
  final bool isPast;

  const ExamCard({
    super.key,
    required this.exam,
    required this.isPast,
  });

  String _two(int n) => n.toString().padLeft(2, '0');

  String _formatDateTime(DateTime dt) {
    final date = '${_two(dt.day)}.${_two(dt.month)}.${dt.year}';
    final time = '${_two(dt.hour)}:${_two(dt.minute)}';
    return '$date  •  $time';
  }

  @override
  Widget build(BuildContext context) {
    final bg = isPast ? Colors.grey.shade200 : Colors.white;
    final border = isPast ? Colors.grey.shade400 : Colors.blue.shade300;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: exam);
      },
      child: Card(
        color: bg,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: border, width: 1.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      exam.subject,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isPast ? Colors.black54 : Colors.black87,
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isPast ? Colors.red.shade100 : Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isPast ? 'Overdue' : 'Upcoming',
                      style: TextStyle(
                        color: isPast ? Colors.red.shade800 : Colors.green.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),


              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 18),
                  const SizedBox(width: 6),
                  Text(_formatDateTime(exam.dateTime)),
                ],
              ),

              const SizedBox(height: 6),


              Row(
                children: [
                  const Icon(Icons.location_on, size: 18),
                  const SizedBox(width: 6),
                  Expanded(child: Text(exam.rooms.join(', '))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
