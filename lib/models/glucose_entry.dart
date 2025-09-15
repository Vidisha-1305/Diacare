class GlucoseEntry {
  final double value;
  final DateTime date;

  GlucoseEntry({
    required this.value,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'date': date.toIso8601String(),
    };
  }

  factory GlucoseEntry.fromMap(Map<String, dynamic> map) {
    return GlucoseEntry(
      value: map['value']?.toDouble() ?? 0.0,
      date: DateTime.parse(map['date']),
    );
  }
}
