import 'package:flutter/material.dart';
import '../../shared/theme/app_theme.dart';

class DoctorPatientsScreen extends StatelessWidget {
  const DoctorPatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patients')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search patients...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 10,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) => _PatientCard(
                name: 'Patient ${index + 1}',
                age: 25 + index * 3,
                gender: index % 2 == 0 ? 'Male' : 'Female',
                condition: ['Hypertension', 'Diabetes', 'Asthma', 'Migraine', 'Arthritis'][index % 5],
                lastVisit: '2024-01-${15 + index}',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PatientCard extends StatelessWidget {
  final String name;
  final int age;
  final String gender;
  final String condition;
  final String lastVisit;

  const _PatientCard({
    required this.name,
    required this.age,
    required this.gender,
    required this.condition,
    required this.lastVisit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                child: Text(name[0], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text('$age years, $gender', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary)),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: AppTheme.primaryColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                          child: Text(condition, style: TextStyle(fontSize: 11, color: AppTheme.primaryColor, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Last visit: $lastVisit', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary)),
                  ],
                ),
              ),
              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}