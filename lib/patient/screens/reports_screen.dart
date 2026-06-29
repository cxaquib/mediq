import 'package:flutter/material.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/custom_button.dart';

class PatientReportsScreen extends StatelessWidget {
  const PatientReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = [
      {'name': 'Blood Test Report', 'date': 'Jan 15, 2024', 'type': 'Lab Report', 'status': 'Ready'},
      {'name': 'X-Ray Chest', 'date': 'Jan 10, 2024', 'type': 'Radiology', 'status': 'Ready'},
      {'name': 'MRI Brain', 'date': 'Dec 28, 2023', 'type': 'Radiology', 'status': 'Processing'},
      {'name': 'Urine Analysis', 'date': 'Dec 20, 2023', 'type': 'Lab Report', 'status': 'Ready'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('My Reports')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: reports.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final report = reports[index];
          return Card(
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(report['type'] == 'Lab Report' ? Icons.biotech : Icons.image, color: AppTheme.primaryColor),
              ),
              title: Text(report['name']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${report['date']} • ${report['type']}'),
                  const SizedBox(height: 4),
                  Chip(
                    label: Text(report['status']!, style: const TextStyle(fontSize: 12)),
                    backgroundColor: report['status'] == 'Ready' ? AppTheme.successColor.withValues(alpha: 0.2) : AppTheme.warningColor.withValues(alpha: 0.2),
                    labelStyle: TextStyle(color: report['status'] == 'Ready' ? AppTheme.successColor : AppTheme.warningColor),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {},
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}