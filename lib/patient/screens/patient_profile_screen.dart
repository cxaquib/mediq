import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/providers/auth_provider.dart';
import '../../shared/providers/user_provider.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/custom_button.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<UserProvider>(
          builder: (context, user, _) => Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                        child: Text(
                          user.name?.isNotEmpty == true ? user.name![0].toUpperCase() : 'J',
                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppTheme.primaryColor),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(user.name ?? 'John Doe', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      Text(user.email ?? 'john@example.com', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary)),
                      const SizedBox(height: 16),
                      CustomButton(text: 'Edit Profile', isOutlined: true, onPressed: () {}, width: 180),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _InfoCard(
                title: 'Personal Information',
                children: [
                  _InfoRow(label: 'Phone', value: user.phone ?? '+1 234 567 890', icon: Icons.phone),
                  _InfoRow(label: 'Date of Birth', value: 'January 1, 1990', icon: Icons.cake),
                  _InfoRow(label: 'Gender', value: 'Male', icon: Icons.person),
                  _InfoRow(label: 'Blood Group', value: 'O+', icon: Icons.bloodtype),
                ],
              ),
              const SizedBox(height: 16),
              _InfoCard(
                title: 'Address',
                children: [
                  _InfoRow(label: 'Address', value: '123 Main Street, City, State 12345', icon: Icons.location_on),
                  _InfoRow(label: 'Emergency Contact', value: '+1 987 654 321', icon: Icons.emergency),
                ],
              ),
              const SizedBox(height: 16),
              _InfoCard(
                title: 'Medical Information',
                children: [
                  _InfoRow(label: 'Allergies', value: 'Penicillin, Peanuts', icon: Icons.warning),
                  _InfoRow(label: 'Chronic Conditions', value: 'Hypertension', icon: Icons.medical_services),
                  _InfoRow(label: 'Current Medications', value: 'Lisinopril 10mg daily', icon: Icons.medication),
                ],
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Logout',
                isOutlined: true,
                onPressed: () => context.read<AuthProvider>().logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _InfoCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoRow({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppTheme.textSecondary),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.textSecondary)),
              Text(value, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}