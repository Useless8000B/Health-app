import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/exam_model.dart';
import '../colors.dart';
import '../services/api_service.dart';

class ScheduledExamsScreen extends StatefulWidget {
  const ScheduledExamsScreen({super.key});

  @override
  State<ScheduledExamsScreen> createState() => _ScheduledExamsScreenState();
}

class _ScheduledExamsScreenState extends State<ScheduledExamsScreen> {
  final ApiService apiService = ApiService();
  late Future<List<ExamRecord>> examsFuture;

  @override
  void initState() {
    super.initState();
    _loadExams();
  }

  Future<void> _loadExams() async {
    setState(() {
      examsFuture = apiService.getExams();
    });
  }

  bool _isPast(DateTime examDateTime) {
    return examDateTime.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadExams,
        color: Colors.blueAccent,
        backgroundColor: AppColors.cardDark,
        child: FutureBuilder<List<ExamRecord>>(
          future: examsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Center(child: Text("Error: ${snapshot.error}")),
                  ),
                ],
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: const Center(child: Text("No exams scheduled")),
                  ),
                ],
              );
            }

            final allExams = snapshot.data!;
            final upcomingExams = allExams
                .where((e) => !_isPast(e.examDateTime))
                .toList();
            final pastExams = allExams
                .where((e) => _isPast(e.examDateTime))
                .toList();

            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                if (upcomingExams.isNotEmpty) ...[
                  _buildSectionHeader("UPCOMING EXAMS"),
                  const SizedBox(height: 10),
                  ...upcomingExams.map(
                    (exam) => _buildExamBubble(
                      title: exam.examType,
                      subtitle: exam.examLocation,
                      time:
                          "${DateFormat("MMM d").format(exam.examDateTime)}, ${DateFormat("HH:mm").format(exam.examDateTime)}",
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
                      time:
                          "${DateFormat("MMM d").format(exam.examDateTime)}, ${DateFormat("HH:mm").format(exam.examDateTime)}",
                      isPast: true,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
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
              border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
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
                Text(subtitle, style: TextStyle(fontSize: 14)),
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
                      color: isPast ? Colors.grey : (Colors.blueAccent[100]),
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
