import 'package:flutter/material.dart';

class ScheduleExamScreen extends StatelessWidget {
  const ScheduleExamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> examTypes = ["General Checkup", "Blood Test", "X-Ray"];
    final selectedDateTime = ValueNotifier<DateTime?>(null);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Appointment Details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              _buildLabel("Phone Number"),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration(
                  "Enter phone",
                  Icons.phone,
                ),
              ),

              const SizedBox(height: 20),

              _buildLabel("Type of Exam"),
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF24262C),
                items: examTypes
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (val) {},
                decoration: _inputDecoration(
                  "Select exam",
                  Icons.medical_information,
                ),
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "SCHEDULE NOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}