import 'package:flutter/material.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/custom_button.dart';

class LabTestRequestsScreen extends StatefulWidget {
  const LabTestRequestsScreen({super.key});

  @override
  State<LabTestRequestsScreen> createState() => _LabTestRequestsScreenState();
}

class _LabTestRequestsScreenState extends State<LabTestRequestsScreen> {
  int _selectedTab = 0;
  final tabs = ['Pending', 'Processing', 'Completed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Requests'),
        bottom: TabBar(
          tabs: tabs.map((t) => Tab(text: t)).toList(),
          onTap: (i) => setState(() => _selectedTab = i),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final statuses = ['Pending', 'Processing', 'Completed'];
          final status = statuses[index % 3];
          return Card(
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                child: Text('P${index + 1}', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
              ),
              title: Text('Patient ${index + 1} - ${['CBC', 'Lipid Profile', 'Thyroid', 'Liver Function'][index % 4]}'),
              subtitle: Text('Dr. ${['Smith', 'Johnson', 'Williams'][index % 3]} • ${DateTime.now().subtract(Duration(days: index % 30)).toString().split(' ')[0]}'),
              trailing: Chip(
                label: Text(status, style: const TextStyle(fontSize: 11)),
                backgroundColor: status == 'Completed' ? AppTheme.successColor.withValues(alpha: 0.2) : status == 'Processing' ? AppTheme.warningColor.withValues(alpha: 0.2) : AppTheme.primaryColor.withValues(alpha: 0.2),
                labelStyle: TextStyle(color: status == 'Completed' ? AppTheme.successColor : status == 'Processing' ? AppTheme.warningColor : AppTheme.primaryColor),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Patient Details', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      _DetailRow(label: 'Age/Gender', value: '${25 + index * 2}/${index % 2 == 0 ? 'M' : 'F'}'),
                      _DetailRow(label: 'Doctor', value: 'Dr. ${['Smith', 'Johnson', 'Williams'][index % 3]}'),
                      _DetailRow(label: 'Priority', value: ['Normal', 'Urgent', 'Stat'][index % 3]),
                      _DetailRow(label: 'Sample Collected', value: index % 3 != 0 ? 'Yes' : 'Pending'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: CustomButton(text: status == 'Pending' ? 'Start Processing' : 'View Details', isOutlined: status != 'Pending', onPressed: () {})),
                          const SizedBox(width: 12),
                          if (status == 'Processing')
                            Expanded(child: CustomButton(text: 'Mark Complete', onPressed: () {})),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary))),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}