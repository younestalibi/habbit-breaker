class ProgressModel {
  final DateTime startDate;
  final int cleanDays;
  final int relapseCount;

  ProgressModel({
    required this.startDate,
    required this.cleanDays,
    required this.relapseCount,
  });

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      startDate: DateTime.parse(json['start_date']),
      cleanDays: json['clean_days'],
      relapseCount: json['relapse_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate.toIso8601String(),
      'clean_days': cleanDays,
      'relapse_count': relapseCount,
    };
  }
}
