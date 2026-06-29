import 'package:flutter/material.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/custom_button.dart';

class DoctorViewHistoryScreen extends StatelessWidget {
  const DoctorViewHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View History')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search history...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                    foregroundColor: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 15,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) => Card(
                child: ExpansionTile(
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                    child: Icon(Icons.medical_services, color: AppTheme.primaryColor),
                  ),
                  title: Text('Patient ${index + 1} - ${['Consultation', 'Follow-up', 'Emergency', 'Check-up'][index % 4]}'),
                  subtitle: Text('Jan ${1 + index}, 2024 · ${['Completed', 'Cancelled', 'Rescheduled'][index % 3]}'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Diagnosis: ${['Hypertension', 'Diabetes Type 2', 'Bronchitis', 'Migraine'][index % 4]}'),
                          const SizedBox(height: 8),
                          Text('Prescription: ${['Medication A, B', 'Insulin, Metformin', 'Antibiotics', 'Pain relievers'][index % 4]}'),
                          const SizedBox(height: 8),
                          Text('Notes: Patient responded well to treatment. Follow-up recommended in 2 weeks.'),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              CustomButton(text: 'View Report', isOutlined: true, onPressed: () {}, width: 140),
                              const SizedBox(width: 12),
                              CustomButton(text: 'Add Notes', isOutlined: true, onPressed: () {}, width: 140),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}