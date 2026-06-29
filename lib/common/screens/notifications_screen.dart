import 'package:flutter/material.dart';
import '../../shared/theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {'title': 'Appointment Confirmed', 'message': 'Your appointment with Dr. Sarah Johnson is confirmed for Jan 15 at 10:00 AM', 'time': '2 hours ago', 'type': 'appointment', 'read': false},
      {'title': 'Lab Report Ready', 'message': 'Your Complete Blood Count report is now available for download', 'time': '5 hours ago', 'type': 'lab', 'read': false},
      {'title': 'Prescription Updated', 'message': 'Dr. Michael Chen has updated your prescription. Please review.', 'time': '1 day ago', 'type': 'prescription', 'read': true},
      {'title': 'New Message', 'message': 'You have a new message from Dr. Emily Davis regarding your follow-up', 'time': '2 days ago', 'type': 'message', 'read': true},
      {'title': 'Appointment Reminder', 'message': 'Reminder: Your appointment with Dr. Robert Wilson is tomorrow at 11:00 AM', 'time': '3 days ago', 'type': 'appointment', 'read': true},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return Card(
            color: notif['read'] as bool ? null : AppTheme.primaryColor.withValues(alpha: 0.05),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _getTypeColor(notif['type'] as String).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(_getTypeIcon(notif['type'] as String), color: _getTypeColor(notif['type'] as String), size: 20),
              ),
              title: Text(notif['title'] as String, style: TextStyle(fontWeight: (notif['read'] as bool) ? FontWeight.normal : FontWeight.w600)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(notif['message'] as String),
                  const SizedBox(height: 4),
                  Text(notif['time'] as String, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary)),
                ],
              ),
              trailing: (notif['read'] as bool) ? null : Container(width: 8, height: 8, decoration: BoxDecoration(color: AppTheme.primaryColor, shape: BoxShape.circle)),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'appointment': return AppTheme.primaryColor;
      case 'lab': return AppTheme.secondaryColor;
      case 'prescription': return AppTheme.warningColor;
      case 'message': return AppTheme.successColor;
      default: return AppTheme.primaryColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'appointment': return Icons.calendar_today;
      case 'lab': return Icons.science;
      case 'prescription': return Icons.medication;
      case 'message': return Icons.message;
      default: return Icons.notifications;
    }
  }
}