import 'package:flutter/material.dart';
import '../../shared/theme/app_theme.dart';

class DoctorAppointmentsScreen extends StatefulWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  State<DoctorAppointmentsScreen> createState() => _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends State<DoctorAppointmentsScreen> {
  int _selectedTab = 0;
  final tabs = ['Today', 'Upcoming', 'Past'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: TabBar(
              tabs: tabs.map((t) => Tab(text: t)).toList(),
              onTap: (i) => setState(() => _selectedTab = i),
              indicatorColor: AppTheme.primaryColor,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: 8,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                    child: Icon(Icons.person, color: AppTheme.primaryColor),
                  ),
                  title: Text('Patient ${index + 1}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${_selectedTab == 0 ? 'Today' : _selectedTab == 1 ? 'Tomorrow' : 'Jan ${20 - index}'} at ${9 + index}:00 AM'),
                      Text('General Consultation', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  trailing: Chip(
                    label: Text(['Confirmed', 'Pending', 'Completed'][index % 3]),
                    backgroundColor: [AppTheme.successColor, AppTheme.warningColor, AppTheme.primaryColor][index % 3].withValues(alpha: 0.1),
                    labelStyle: TextStyle(color: [AppTheme.successColor, AppTheme.warningColor, AppTheme.primaryColor][index % 3]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}