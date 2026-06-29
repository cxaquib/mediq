import 'package:flutter/material.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/custom_button.dart';

class DownloadReportsScreen extends StatelessWidget {
  const DownloadReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = [
      {'name': 'Complete Blood Count', 'date': 'Jan 15, 2024', 'size': '2.4 MB', 'format': 'PDF'},
      {'name': 'Chest X-Ray Report', 'date': 'Jan 10, 2024', 'size': '5.1 MB', 'format': 'PDF'},
      {'name': 'MRI Brain Scan', 'date': 'Dec 28, 2023', 'size': '45.2 MB', 'format': 'DICOM'},
      {'name': 'Urinalysis Results', 'date': 'Dec 20, 2023', 'size': '1.8 MB', 'format': 'PDF'},
      {'name': 'Lipid Profile', 'date': 'Nov 15, 2023', 'size': '2.1 MB', 'format': 'PDF'},
      {'name': 'Thyroid Function Test', 'date': 'Nov 10, 2023', 'size': '1.9 MB', 'format': 'PDF'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Download Reports')),
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
                child: Icon(Icons.description, color: AppTheme.primaryColor),
              ),
              title: Text(report['name']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${report['date']} • ${report['size']}'),
                  const SizedBox(height: 4),
                  Chip(
                    label: Text(report['format']!, style: const TextStyle(fontSize: 11)),
                    backgroundColor: AppTheme.secondaryColor.withValues(alpha: 0.2),
                    labelStyle: TextStyle(color: AppTheme.secondaryColor),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.download, color: AppTheme.primaryColor),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Downloading ${report['name']}...')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}