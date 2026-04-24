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
    // Mock data
    DateTime now = DateTime.now();
    allExams = [
      ExamRecord(
        examType: "General Checkup",
        examLocation: "Central Hospital - Room 300",
        examDate: DateFormat("MMM d, HH:mm").format(now.add(const Duration(days: 2))),
      ),
      ExamRecord(
        examType: "Blood Test",
        examLocation: "Lab Corp",
        examDate: DateFormat("MMM d, HH:mm").format(now.add(const Duration(days: 5))),
      ),
      ExamRecord(
        examType: "X-Ray",
        examLocation: "Imaging Center",
        examDate: DateFormat("MMM d, HH:mm").format(now.subtract(const Duration(days: 3))),
      ),
    ];
  }

  bool _isPast(String dateStr) {
    try {
      DateFormat format = DateFormat("MMM d, HH:mm");
      DateTime parsedDate = format.parse(dateStr);

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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final upcomingExams = allExams.where((e) => !_isPast(e.examDate)).toList();
    final pastExams = allExams.where((e) => _isPast(e.examDate)).toList();

    return Scaffold(
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Scheduled Exams",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black87,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: allExams.isEmpty
          ? const Center(child: Text("No exams scheduled"))
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                if (upcomingExams.isNotEmpty) ...[
                  _buildSectionHeader(isDark, "UPCOMING EXAMS"),
                  const SizedBox(height: 10),
                  ...upcomingExams.map(
                    (exam) => _buildExamBubble(
                      isDark,
                      title: exam.examType,
                      subtitle: exam.examLocation,
                      time: exam.examDate,
                      isPast: false,
                    ),
                  ),
                ],
                if (pastExams.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _buildSectionHeader(isDark, "PAST EXAMS"),
                  const SizedBox(height: 10),
                  ...pastExams.map(
                    (exam) => _buildExamBubble(
                      isDark,
                      title: exam.examType,
                      subtitle: exam.examLocation,
                      time: exam.examDate,
                      isPast: true,
                    ),
                  ),
                ],
              ],
            ),
    );
  }

  Widget _buildSectionHeader(bool isDark, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 12,
        letterSpacing: 1.2,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white38 : Colors.black38,
      ),
    );
  }

  Widget _buildExamBubble(
    bool isDark, {
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
          color: isDark ? AppColors.cardDark : Colors.white,
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
                  color: isDark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.grey[200]!,
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
                          color: isDark ? Colors.white : Colors.black87,
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
                      color: isDark ? Colors.white54 : Colors.black54,
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
                          ? (isDark ? Colors.white10 : Colors.grey[100])
                          : (isDark
                                ? Colors.blueAccent.withOpacity(0.1)
                                : AppColors.accentLight),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      isPast ? "Completed: $time" : time,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isPast
                            ? Colors.grey
                            : (isDark
                                  ? Colors.blueAccent[100]
                                  : Colors.blueAccent[700]),
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