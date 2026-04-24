import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/exam_model.dart';
import '../colors.dart';

class ScheduledExamsScreen extends StatefulWidget {
  const ScheduledExamsScreen({super.key});

  @override
  State<ScheduledExamsScreen> createState() => _ScheduledExamsScreenState();
}

class _ScheduledExamsScreenState extends State<ScheduledExamsScreen> {
  late List<ExamRecord> allExams;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    allExams = [
      ExamRecord(
        examType: "General Checkup",
        examLocation: "Central Hospital - Room 300",
        examDate: DateFormat("MMM d").format(now.add(const Duration(days: 2))),
        examTime: "09:00",
      ),
      ExamRecord(
        examType: "Blood Test",
        examLocation: "Lab Corp",
        examDate: DateFormat("MMM d").format(now.add(const Duration(days: 5))),
        examTime: "14:30",
      ),
      ExamRecord(
        examType: "X-Ray",
        examLocation: "Imaging Center",
        examDate: DateFormat("MMM d").format(now.subtract(const Duration(days: 3))),
        examTime: "11:15",
      ),
    ];
  }

  bool _isPast(String dateStr, String timeStr) {
    try {
      DateFormat format = DateFormat("MMM d HH:mm");
      DateTime parsedDate = format.parse("$dateStr $timeStr");

      DateTime now = DateTime.now();
      DateTime examDateTime = DateTime(
        now.year,
        parsedDate.month,
        parsedDate.day,
        parsedDate.hour,
        parsedDate.minute,
      );

      return examDateTime.isBefore(now);
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final upcomingExams = allExams.where((e) => !_isPast(e.examDate, e.examTime)).toList();
    final pastExams = allExams.where((e) => _isPast(e.examDate, e.examTime)).toList();

    return Scaffold(
      body: allExams.isEmpty
          ? const Center(child: Text("No exams scheduled"))
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                if (upcomingExams.isNotEmpty) ...[
                  _buildSectionHeader("UPCOMING EXAMS"),
                  const SizedBox(height: 10),
                  ...upcomingExams.map(
                    (exam) => _buildExamBubble(
                      title: exam.examType,
                      subtitle: exam.examLocation,
                      time: "${exam.examDate}, ${exam.examTime}",
                      isPast: false,
                    ),
                  ),
                ],
                if (pastExams.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _buildSectionHeader("PAST EXAMS"),
                  const SizedBox(height: 10),
                  ...pastExams.map(
                    (exam) => _buildExamBubble(
                      title: exam.examType,
                      subtitle: exam.examLocation,
                      time: "${exam.examDate}, ${exam.examTime}",
                      isPast: true,
                    ),
                  ),
                ],
              ],
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 12,
        letterSpacing: 1.2,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildExamBubble({
    required String title,
    required String subtitle,
    required String time,
    required bool isPast,
  }) {
    return Opacity(
      opacity: isPast ? 0.6 : 1.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Material(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(24),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.05)
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isPast)
                        const Icon(
                          Icons.check_circle_outline,
                          size: 18,
                          color: Colors.grey,
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isPast
                          ? (Colors.white10)
                          : (Colors.blueAccent.withValues(alpha: 0.1)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      isPast ? "Completed: $time" : time,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isPast
                            ? Colors.grey
                            : (Colors.blueAccent[100]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}