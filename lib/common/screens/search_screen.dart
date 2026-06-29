import 'package:flutter/material.dart';
import '../../shared/theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'All';
  final categories = ['All', 'Doctors', 'Patients', 'Reports', 'Appointments', 'Labs'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(icon: const Icon(Icons.clear), onPressed: () => setState(() => _searchController.clear()))
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = categories[index];
                return FilterChip(
                  label: Text(cat),
                  selected: _selectedCategory == cat,
                  onSelected: (_) => setState(() => _selectedCategory = cat),
                  selectedColor: AppTheme.primaryColor.withValues(alpha: 0.2),
                  checkmarkColor: AppTheme.primaryColor,
                );
              },
            ),
          ),
          Expanded(
            child: _buildResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    if (_searchController.text.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text('Search for doctors, patients, reports...', style: TextStyle(color: Colors.grey[600], fontSize: 16)),
          ],
        ),
      );
    }

    final results = [
      {'type': 'Doctor', 'name': 'Dr. Sarah Johnson', 'detail': 'Cardiologist • 4.9★', 'icon': Icons.medical_services},
      {'type': 'Patient', 'name': 'John Doe', 'detail': 'Male, 35 • Hypertension', 'icon': Icons.person},
      {'type': 'Report', 'name': 'CBC Report', 'detail': 'Jan 15, 2024 • Ready', 'icon': Icons.description},
      {'type': 'Appointment', 'name': 'Follow-up', 'detail': 'Jan 20, 10:00 AM', 'icon': Icons.calendar_today},
    ].where((r) => _selectedCategory == 'All' || r['type'] == _selectedCategory).toList();

    if (results.isEmpty) {
      return Center(child: Text('No results found for "${_searchController.text}"'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final r = results[index];
        return Card(
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppTheme.primaryColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
              child: Icon(r['icon'] as IconData, color: AppTheme.primaryColor, size: 24),
            ),
            title: Text(r['name'] as String),
            subtitle: Text(r['detail'] as String),
            trailing: Chip(label: Text(r['type'] as String, style: const TextStyle(fontSize: 10)), backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1), labelStyle: TextStyle(color: AppTheme.primaryColor)),
            onTap: () {},
          ),
        );
      },
    );
  }
}