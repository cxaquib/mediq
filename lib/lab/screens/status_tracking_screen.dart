import 'package:flutter/material.dart';
import '../../shared/theme/app_theme.dart';

class LabStatusTrackingScreen extends StatelessWidget {
  const LabStatusTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final testRequests = [
      {'test': 'CBC', 'patient': 'John Doe', 'status': 'Completed', 'progress': 1.0, 'color': AppTheme.successColor},
      {'test': 'Lipid Profile', 'patient': 'Jane Smith', 'status': 'Processing', 'progress': 0.6, 'color': AppTheme.warningColor},
      {'test': 'Thyroid Panel', 'patient': 'Robert Brown', 'status': 'Sample Received', 'progress': 0.3, 'color': AppTheme.primaryColor},
      {'test': 'Liver Function', 'patient': 'Maria Garcia', 'status': 'Pending Collection', 'progress': 0.1, 'color': Colors.grey},
      {'test': 'Kidney Function', 'patient': 'David Wilson', 'status': 'Report Generated', 'progress': 0.9, 'color': AppTheme.primaryColor},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Status Tracking')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: testRequests.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final test = testRequests[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(test['test'] as String, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                            Text('Patient: ${test['patient']}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary)),
                          ],
                        ),
                      ),
                      Chip(
                        label: Text(test['status'] as String, style: TextStyle(color: test['color'] as Color, fontSize: 12, fontWeight: FontWeight.w600)),
                        backgroundColor: (test['color'] as Color).withValues(alpha: 0.15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Progress', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary)),
                          Text('${((test['progress'] as double) * 100).toInt()}%', style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: test['progress'] as double,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation(test['color'] as Color),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _StatusStep(label: 'Ordered', completed: true, active: false),
                      _StatusConnector(completed: true),
                      _StatusStep(label: 'Collected', completed: (test['progress'] as double) >= 0.3, active: (test['progress'] as double) >= 0.1 && (test['progress'] as double) < 0.3),
                      _StatusConnector(completed: (test['progress'] as double) >= 0.3),
                      _StatusStep(label: 'Processing', completed: (test['progress'] as double) >= 0.6, active: (test['progress'] as double) >= 0.3 && (test['progress'] as double) < 0.6),
                      _StatusConnector(completed: (test['progress'] as double) >= 0.6),
                      _StatusStep(label: 'Review', completed: (test['progress'] as double) >= 0.9, active: (test['progress'] as double) >= 0.6 && (test['progress'] as double) < 0.9),
                      _StatusConnector(completed: (test['progress'] as double) >= 0.9),
                      _StatusStep(label: 'Complete', completed: (test['progress'] as double) >= 1.0, active: (test['progress'] as double) >= 0.9 && (test['progress'] as double) < 1.0),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StatusStep extends StatelessWidget {
  final String label;
  final bool completed;
  final bool active;

  const _StatusStep({required this.label, required this.completed, required this.active});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: completed ? AppTheme.successColor : active ? AppTheme.primaryColor : Colors.grey[300],
              border: Border.all(color: completed || active ? AppTheme.successColor : Colors.grey[300]!, width: 2),
            ),
            child: completed ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
          ),
          const SizedBox(height: 4),
          Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: completed || active ? AppTheme.textPrimary : AppTheme.textSecondary,
            fontWeight: completed || active ? FontWeight.w600 : FontWeight.normal,
          ), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _StatusConnector extends StatelessWidget {
  final bool completed;

  const _StatusConnector({required this.completed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 3,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: completed ? AppTheme.successColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(1.5),
        ),
      ),
    );
  }
}