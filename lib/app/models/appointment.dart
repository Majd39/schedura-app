class Appointment {
  final String doctorName;
  final String specialty;
  final DateTime dateTime;
  final String status;
  final int rating;

  Appointment({
    required this.doctorName,
    required this.specialty,
    required this.dateTime,
    required this.status,
    this.rating = 0,
  });
}
