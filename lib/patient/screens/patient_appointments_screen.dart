import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/custom_button.dart';

class PatientAppointmentsScreen extends StatelessWidget {
  const PatientAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final upcoming = [
      {'doctor': 'Dr. Sarah Johnson', 'specialty': 'Cardiologist', 'date': DateTime.now().add(const Duration(days: 2)), 'time': '10:00 AM', 'type': 'Video Consultation'},
      {'doctor': 'Dr. Michael Chen', 'specialty': 'Dermatologist', 'date': DateTime.now().add(const Duration(days: 5)), 'time': '2:30 PM', 'type': 'In-Person'},
    ];
    final past = [
      {'doctor': 'Dr. Emily Davis', 'specialty': 'General Physician', 'date': DateTime.now().subtract(const Duration(days: 10)), 'time': '9:00 AM', 'type': 'Completed'},
      {'doctor': 'Dr. Robert Wilson', 'specialty': 'Orthopedic', 'date': DateTime.now().subtract(const Duration(days: 30)), 'time': '11:00 AM', 'type': 'Completed'},
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Appointments'),
          bottom: const TabBar(tabs: [Tab(text: 'Upcoming'), Tab(text: 'Past')]),
        ),
        body: TabBarView(
          children: [
            ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: upcoming.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final appt = upcoming[index];
                return _AppointmentCard(
                  doctor: appt['doctor'] as String,
                  specialty: appt['specialty'] as String,
                  date: appt['date'] as DateTime,
                  time: appt['time'] as String,
                  type: appt['type'] as String,
                  isUpcoming: true,
                  onCancel: () {},
                  onReschedule: () {},
                );
              },
            ),
            ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: past.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final appt = past[index];
                return _AppointmentCard(
                  doctor: appt['doctor'] as String,
                  specialty: appt['specialty'] as String,
                  date: appt['date'] as DateTime,
                  time: appt['time'] as String,
                  type: appt['type'] as String,
                  isUpcoming: false,
                  onViewReport: () {},
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final String doctor;
  final String specialty;
  final DateTime date;
  final String time;
  final String type;
  final bool isUpcoming;
  final VoidCallback? onCancel;
  final VoidCallback? onReschedule;
  final VoidCallback? onViewReport;

  const _AppointmentCard({
    required this.doctor,
    required this.specialty,
    required this.date,
    required this.time,
    required this.type,
    required this.isUpcoming,
    this.onCancel,
    this.onReschedule,
    this.onViewReport,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                  child: Text(doctor.split(' ').last[0], style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doctor, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                      Text(specialty, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary)),
                    ],
                  ),
                ),
                Chip(
                  label: Text(type, style: const TextStyle(fontSize: 11)),
                  backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                  labelStyle: TextStyle(color: AppTheme.primaryColor),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: AppTheme.textSecondary),
                const SizedBox(width: 8),
                Text(DateFormat('EEEE, MMM d, yyyy').format(date), style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(width: 24),
                Icon(Icons.access_time, size: 16, color: AppTheme.textSecondary),
                const SizedBox(width: 8),
                Text(time, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            if (isUpcoming) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: CustomButton(text: 'Cancel', isOutlined: true, onPressed: onCancel)),
                  const SizedBox(width: 12),
                  Expanded(child: CustomButton(text: 'Reschedule', onPressed: onReschedule)),
                ],
              ),
            ] else ...[
              const SizedBox(height: 16),
              CustomButton(text: 'View Report', isOutlined: true, onPressed: onViewReport, width: 150),
            ],
          ],
        ),
      ),
    );
  }
}