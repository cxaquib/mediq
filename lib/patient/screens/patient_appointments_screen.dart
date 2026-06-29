import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/custom_button.dart';

class PatientAppointmentsScreen extends StatelessWidget {
  const PatientAppointmentsScreen({super.key});

  DateTime _parseDateTime(DateTime date, String time) {
    final parts = time.split(' ');
    final timeParts = parts[0].split(':');
    var hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    final amPm = parts[1];
    if (amPm == 'PM' && hour != 12) hour += 12;
    if (amPm == 'AM' && hour == 12) hour = 0;
    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final upcoming = [
      {
        'doctor': 'Dr. Sarah Johnson',
        'specialty': 'Cardiologist',
        'date': DateTime.now().add(const Duration(days: 2)),
        'time': '10:00 AM',
        'type': 'Video Consultation'
      },
      {
        'doctor': 'Dr. Michael Chen',
        'specialty': 'Dermatologist',
        'date': DateTime.now().add(const Duration(days: 5)),
        'time': '2:30 PM',
        'type': 'In-Person'
      },
    ];
    final past = [
      {
        'doctor': 'Dr. Emily Davis',
        'specialty': 'General Physician',
        'date': DateTime.now().subtract(const Duration(days: 10)),
        'time': '9:00 AM',
        'type': 'Completed'
      },
      {
        'doctor': 'Dr. Robert Wilson',
        'specialty': 'Orthopedic',
        'date': DateTime.now().subtract(const Duration(days: 30)),
        'time': '11:00 AM',
        'type': 'Completed'
      },
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Appointments'),
          bottom:
              const TabBar(tabs: [Tab(text: 'Upcoming'), Tab(text: 'Past')]),
        ),
        body: TabBarView(
          children: [
            ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: upcoming.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final appt = upcoming[index];
                final apptDateTime = _parseDateTime(
                    appt['date'] as DateTime, appt['time'] as String);
                final isPassed = apptDateTime.isBefore(now);
                return _AppointmentCard(
                  doctor: appt['doctor'] as String,
                  specialty: appt['specialty'] as String,
                  date: appt['date'] as DateTime,
                  time: appt['time'] as String,
                  type: appt['type'] as String,
                  isUpcoming: true,
                  isPassed: isPassed,
                  onCancel: () => _showCancelDialog(context),
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
          onPressed: () => context.push('/patient/find-doctors'),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content:
            const Text('Are you sure you want to cancel this appointment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Keep Appointment',
                style: TextStyle(color: AppTheme.primaryColor)),
          ),
          CustomButton(
            text: 'Yes, Cancel',
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Appointment cancelled successfully'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
            width: 130,
          ),
        ],
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
  final bool isPassed;
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
    this.isPassed = false,
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
                  child: Text(doctor.split(' ').last[0],
                      style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doctor,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      Text(specialty,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppTheme.textSecondary)),
                    ],
                  ),
                ),
                Chip(
                  label: Text(isPassed ? 'Missed' : type,
                      style: const TextStyle(fontSize: 11)),
                  backgroundColor: isPassed
                      ? Colors.red.withValues(alpha: 0.1)
                      : AppTheme.primaryColor.withValues(alpha: 0.1),
                  labelStyle: TextStyle(
                      color: isPassed ? Colors.red : AppTheme.primaryColor),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.calendar_today,
                    size: 16, color: AppTheme.textSecondary),
                const SizedBox(width: 8),
                Text(DateFormat('EEEE, MMM d, yyyy').format(date),
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(width: 24),
                Icon(Icons.access_time,
                    size: 16, color: AppTheme.textSecondary),
                const SizedBox(width: 8),
                Text(time, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            if (isUpcoming && !isPassed) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: CustomButton(
                          text: 'Cancel',
                          isOutlined: true,
                          onPressed: onCancel)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: CustomButton(
                          text: 'Reschedule', onPressed: onReschedule)),
                ],
              ),
            ] else if (isUpcoming && isPassed) ...[
              const SizedBox(height: 16),
              CustomButton(
                  text: 'Appointment Missed',
                  isOutlined: true,
                  onPressed: null,
                  width: double.infinity),
            ] else ...[
              const SizedBox(height: 16),
              CustomButton(
                  text: 'View Report',
                  isOutlined: true,
                  onPressed: onViewReport,
                  width: 150),
            ],
          ],
        ),
      ),
    );
  }
}
