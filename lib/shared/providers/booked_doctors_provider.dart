import 'package:flutter/foundation.dart';
import '../models/appointment.dart';

class BookedDoctorsProvider extends ChangeNotifier {
  final Set<String> _bookedDoctorNames = {};
  final List<Appointment> _appointments = [];

  bool isBooked(String doctorName) => _bookedDoctorNames.contains(doctorName);

  List<Appointment> get appointments => List.unmodifiable(_appointments);

  void bookDoctor(Appointment appointment) {
    _bookedDoctorNames.add(appointment.doctorName);
    _appointments.add(appointment);
    notifyListeners();
  }
}
