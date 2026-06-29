import 'package:flutter/material.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final String role;

  const ScaffoldWithNavBar({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onTap,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        items: _getNavItems(role),
      ),
    );
  }

  List<BottomNavigationBarItem> _getNavItems(String role) {
    switch (role) {
      case 'doctor':
        return const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Patients'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.upload_file), label: 'Upload Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ];
      case 'patient':
        return const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.download), label: 'Download'),
        ];
      case 'lab':
        return const [
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Test Requests'),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Upload Results'),
          BottomNavigationBarItem(icon: Icon(Icons.track_changes), label: 'Status'),
        ];
      default:
        return const [];
    }
  }
}