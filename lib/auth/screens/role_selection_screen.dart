import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../shared/providers/auth_provider.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/custom_button.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roles = [
      {'role': UserRole.patient, 'icon': Icons.person, 'title': 'Patient', 'subtitle': 'Access your health records, book appointments, view reports'},
      {'role': UserRole.doctor, 'icon': Icons.medical_services, 'title': 'Doctor', 'subtitle': 'Manage patients, appointments, upload medical reports'},
      {'role': UserRole.admin, 'icon': Icons.science, 'title': 'Lab Technician', 'subtitle': 'Handle test requests, upload results, track status'},
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Icon(Icons.local_hospital, size: 80, color: AppTheme.primaryColor),
              const SizedBox(height: 24),
              Text('Select Your Role', style: Theme.of(context).textTheme.displaySmall, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text('Choose how you want to use MediQ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary), textAlign: TextAlign.center),
              const SizedBox(height: 40),
              Expanded(
                child: ListView.separated(
                  itemCount: roles.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final role = roles[index];
                    return _RoleCard(
                      icon: role['icon'] as IconData,
                      title: role['title'] as String,
                      subtitle: role['subtitle'] as String,
                      onTap: () {
                        final auth = context.read<AuthProvider>();
                        auth.updateRole(role['role'] as UserRole);
                        final route = switch (role['role'] as UserRole) {
                          UserRole.patient => '/patient/profile',
                          UserRole.doctor => '/doctor/dashboard',
                          UserRole.admin => '/lab/test-requests',
                        };
                        context.go(route);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Consumer<AuthProvider>(
                builder: (context, auth, _) => CustomButton(
                  text: auth.role != null ? 'Continue as ${auth.role!.name.toUpperCase()}' : 'Select a role to continue',
                  isLoading: false,
                  onPressed: auth.role != null ? () {
                    final route = switch (auth.role!) {
                      UserRole.patient => '/patient/profile',
                      UserRole.doctor => '/doctor/dashboard',
                      UserRole.admin => '/lab/test-requests',
                    };
                    context.go(route);
                  } : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _RoleCard({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppTheme.primaryColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, size: 32, color: AppTheme.primaryColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: AppTheme.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}