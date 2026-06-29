import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../shared/models/appointment.dart';
import '../../shared/providers/booked_doctors_provider.dart';
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Appointments'),
          bottom:
              const TabBar(tabs: [Tab(text: 'Upcoming'), Tab(text: 'Past')]),
        ),
        body: Consumer<BookedDoctorsProvider>(
          builder: (context, booked, _) {
            final now = DateTime.now();
            final allAppts = booked.appointments;
            final upcoming = allAppts
                .where((a) => _parseDateTime(a.date, a.time).isAfter(now))
                .toList();
            final past = allAppts
                .where((a) => _parseDateTime(a.date, a.time).isBefore(now))
                .toList();

            if (allAppts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_today,
                        size: 64,
                        color: AppTheme.textSecondary.withValues(alpha: 0.4)),
                    const SizedBox(height: 16),
                    Text('No appointments yet',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: AppTheme.textSecondary)),
                  ],
                ),
              );
            }

            return TabBarView(
              children: [
                _buildList(context, upcoming, true, booked),
                _buildList(context, past, false, booked),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push('/patient/find-doctors'),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Appointment> appointments,
      bool isUpcoming, BookedDoctorsProvider booked) {
    if (appointments.isEmpty) {
      return Center(
        child: Text(
            isUpcoming ? 'No upcoming appointments' : 'No past appointments',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppTheme.textSecondary)),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: appointments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final appt = appointments[index];
        final apptDateTime = _parseDateTime(appt.date, appt.time);
        final isPassed = apptDateTime.isBefore(DateTime.now());
        return _AppointmentCard(
          doctor: appt.doctorName,
          specialty: appt.specialty,
          date: appt.date,
          time: appt.time,
          type: appt.type,
          isUpcoming: isUpcoming,
          isPassed: isPassed && isUpcoming,
          onCancel: isUpcoming && !isPassed
              ? () => _showCancelDialog(context, appt.doctorName, booked)
              : null,
        );
      },
    );
  }

  void _showCancelDialog(
      BuildContext context, String doctorName, BookedDoctorsProvider booked) {
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

  const _AppointmentCard({
    required this.doctor,
    required this.specialty,
    required this.date,
    required this.time,
    required this.type,
    required this.isUpcoming,
    this.isPassed = false,
    this.onCancel,
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
                      child: CustomButton(text: 'Reschedule', onPressed: null)),
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
              Text('Completed',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppTheme.successColor)),
            ],
          ],
        ),
      ),
    );
  }
}
