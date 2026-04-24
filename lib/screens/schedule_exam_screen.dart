import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/exam_model.dart';

class ScheduleExamScreen extends StatelessWidget {
  ScheduleExamScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<String> examTypes = ["General Checkup", "Blood Test", "X-Ray"];
    final selectedDateTime = ValueNotifier<DateTime?>(null);
    final selectedExam = ValueNotifier<String?>(null);
    final isLoading = ValueNotifier<bool>(false);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Appointment Details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              _buildLabel("Phone Number"),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration(
                  "Enter phone",
                  Icons.phone,
                ),
                validator: (v) => v!.isEmpty ? "Enter phone number" : null,
              ),

              const SizedBox(height: 20),

              _buildLabel("Type of Exam"),
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF24262C),
                items: examTypes
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  selectedExam.value = val;
                },
                decoration: _inputDecoration(
                  "Select exam",
                  Icons.medical_information,
                ),
                validator: (v) => v == null ? "Select an exam type" : null,
              ),

              const SizedBox(height: 20),

              _buildLabel("Date & Time"),
              ValueListenableBuilder<DateTime?>(
                valueListenable: selectedDateTime,
                builder: (context, dateTime, _) {
                  return InkWell(
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      );
                      if (pickedDate != null) {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          selectedDateTime.value = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF24262C),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Color(0xFF1976D2),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            dateTime == null
                                ? "Pick a date & time"
                                : "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}",
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ValueListenableBuilder<bool>(
                  valueListenable: isLoading,
                  builder: (context, loading, _) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976D2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: loading
                          ? null
                          : () async {
                              if (!_formKey.currentState!.validate()) return;
                              if (selectedDateTime.value == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Please select a date and time")),
                                );
                                return;
                              }

                              isLoading.value = true;

                              final newExam = ExamRecord(
                                examType: selectedExam.value!,
                                examLocation: "Central Hospital - Room 300",
                                examDateTime: selectedDateTime.value!,
                              );

                              final apiService = ApiService();
                              bool success = await apiService.addExam(newExam);

                              isLoading.value = false;

                              if (!context.mounted) return;

                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Successfully scheduled"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                _formKey.currentState!.reset();
                                selectedDateTime.value = null;
                                selectedExam.value = null;
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Failed to save. Check server."),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                      child: loading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              "SCHEDULE NOW",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(icon, color: const Color(0xFF1976D2)),
      filled: true,
      fillColor: const Color(0xFF24262C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}