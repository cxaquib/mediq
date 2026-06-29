import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/theme/app_theme.dart';

class DoctorShell extends StatelessWidget {
  final Widget child;

  const DoctorShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex(context),
        onTap: (index) => _onTap(context, index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textSecondary,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Patients'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(
              icon: Icon(Icons.upload_file), label: 'Upload Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.contains('/doctor/patients')) return 1;
    if (location.contains('/doctor/appointments')) return 2;
    if (location.contains('/doctor/upload-reports')) return 3;
    if (location.contains('/doctor/view-history')) return 4;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/doctor/dashboard');
      case 1:
        context.go('/doctor/patients');
      case 2:
        context.go('/doctor/appointments');
      case 3:
        context.go('/doctor/upload-reports');
      case 4:
        context.go('/doctor/view-history');
    }
  }
}
