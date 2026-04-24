class ExamRecord {
  final String examType;
  final String examLocation;
  final DateTime examDateTime;

  ExamRecord({
    required this.examType,
    required this.examLocation,
    required this.examDateTime,
  });

  factory ExamRecord.fromJson(Map<String, dynamic> json) {
    return ExamRecord(
      examType: json['examType'] ?? json['exam_type'] ?? '',
      examLocation: json['examLocation'] ?? json['exam_location'] ?? '',
      examDateTime: DateTime.tryParse((json['examDate'] ?? json['exam_date']).toString()) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'examType': examType,
      'examLocation': examLocation,
      'examDate': examDateTime.toIso8601String(),
    };
  }
}
