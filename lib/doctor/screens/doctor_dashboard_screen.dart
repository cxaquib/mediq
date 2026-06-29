import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../shared/providers/auth_provider.dart';
import '../../shared/providers/user_provider.dart';
import '../../shared/theme/app_theme.dart';

class DoctorDashboardScreen extends StatelessWidget {
  const DoctorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async {
              await context.read<AuthProvider>().logout();
              if (context.mounted) context.go('/auth/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<UserProvider>(
              builder: (context, user, _) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            AppTheme.primaryColor.withValues(alpha: 0.1),
                        child: Icon(Icons.medical_services,
                            size: 30, color: AppTheme.primaryColor),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Dr. ${user.name ?? 'John Doe'}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            Text('General Physician',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppTheme.textSecondary)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Quick Stats',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _StatCard(
                        icon: Icons.people,
                        title: 'Total Patients',
                        count: '127',
                        color: AppTheme.primaryColor)),
                const SizedBox(width: 12),
                Expanded(
                    child: _StatCard(
                        icon: Icons.calendar_today,
                        title: 'Today\'s Appointments',
                        count: '8',
                        color: AppTheme.secondaryColor)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                    child: _StatCard(
                        icon: Icons.description,
                        title: 'Pending Reports',
                        count: '5',
                        color: AppTheme.warningColor)),
                const SizedBox(width: 12),
                Expanded(
                    child: _StatCard(
                        icon: Icons.history,
                        title: 'Completed',
                        count: '1,234',
                        color: AppTheme.successColor)),
              ],
            ),
            const SizedBox(height: 24),
            Text('Recent Activity',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          AppTheme.primaryColor.withValues(alpha: 0.1),
                      child: Icon(Icons.medical_services,
                          color: AppTheme.primaryColor),
                    ),
                    title: Text('Patient ${index + 1} - Consultation'),
                    subtitle: Text('Today, 10:${30 + index} AM'),
                    trailing: Chip(
                      label: Text(index % 2 == 0 ? 'Completed' : 'Pending'),
                      backgroundColor: index % 2 == 0
                          ? AppTheme.successColor.withValues(alpha: 0.1)
                          : AppTheme.warningColor.withValues(alpha: 0.1),
                      labelStyle: TextStyle(
                          color: index % 2 == 0
                              ? AppTheme.successColor
                              : AppTheme.warningColor),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String count;
  final Color color;

  const _StatCard(
      {required this.icon,
      required this.title,
      required this.count,
      required this.color});

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
                Icon(icon, color: color, size: 24),
                const Spacer(),
                Text(count,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(fontWeight: FontWeight.bold, color: color)),
              ],
            ),
            const SizedBox(height: 8),
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppTheme.textSecondary)),
          ],
        ),
      ),
    );
  }
}
