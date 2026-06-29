class Appointment {
  final String doctorName;
  final String specialty;
  final String rating;
  final String fee;
  final DateTime date;
  final String time;
  final String type;
  final String reason;

  const Appointment({
    required this.doctorName,
    required this.specialty,
    required this.rating,
    required this.fee,
    required this.date,
    required this.time,
    required this.type,
    this.reason = '',
  });
}
