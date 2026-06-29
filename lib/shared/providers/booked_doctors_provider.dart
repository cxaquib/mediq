import 'package:flutter/foundation.dart';

class BookedDoctorsProvider extends ChangeNotifier {
  final Set<String> _bookedDoctorNames = {};

  bool isBooked(String doctorName) => _bookedDoctorNames.contains(doctorName);

  void bookDoctor(String doctorName) {
    _bookedDoctorNames.add(doctorName);
    notifyListeners();
  }
}
