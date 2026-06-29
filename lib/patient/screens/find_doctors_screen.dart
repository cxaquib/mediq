import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/theme/app_theme.dart';

class FindDoctorsScreen extends StatefulWidget {
  const FindDoctorsScreen({super.key});

  @override
  State<FindDoctorsScreen> createState() => _FindDoctorsScreenState();
}

class _FindDoctorsScreenState extends State<FindDoctorsScreen> {
  final _searchController = TextEditingController();
  String _selectedSpecialty = 'All';
  final List<String> _specialties = [
    'All',
    'Cardiologist',
    'Dermatologist',
    'Orthopedic',
    'Pediatrician',
    'Neurologist',
    'Ophthalmologist',
    'ENT Specialist',
    'General Physician',
    'Gynecologist',
    'Psychiatrist',
  ];

  final List<Map<String, String>> _allDoctors = [
    {
      'name': 'Dr. Sarah Johnson',
      'specialty': 'Cardiologist',
      'experience': '12 years',
      'rating': '4.8',
      'hospital': 'City Heart Center',
      'fee': '500',
      'available': 'Today'
    },
    {
      'name': 'Dr. Michael Chen',
      'specialty': 'Dermatologist',
      'experience': '8 years',
      'rating': '4.6',
      'hospital': 'Skin Care Clinic',
      'fee': '400',
      'available': 'Tomorrow'
    },
    {
      'name': 'Dr. Emily Davis',
      'specialty': 'General Physician',
      'experience': '15 years',
      'rating': '4.9',
      'hospital': 'MediQ General Hospital',
      'fee': '300',
      'available': 'Today'
    },
    {
      'name': 'Dr. Robert Wilson',
      'specialty': 'Orthopedic',
      'experience': '10 years',
      'rating': '4.7',
      'hospital': 'Bone & Joint Center',
      'fee': '600',
      'available': 'Wed'
    },
    {
      'name': 'Dr. Lisa Anderson',
      'specialty': 'Pediatrician',
      'experience': '9 years',
      'rating': '4.5',
      'hospital': 'Children\'s Health Clinic',
      'fee': '350',
      'available': 'Today'
    },
    {
      'name': 'Dr. James Taylor',
      'specialty': 'Neurologist',
      'experience': '14 years',
      'rating': '4.9',
      'hospital': 'Brain & Spine Institute',
      'fee': '800',
      'available': 'Fri'
    },
    {
      'name': 'Dr. Maria Garcia',
      'specialty': 'Ophthalmologist',
      'experience': '11 years',
      'rating': '4.7',
      'hospital': 'Vision Care Center',
      'fee': '450',
      'available': 'Tomorrow'
    },
    {
      'name': 'Dr. David Kim',
      'specialty': 'ENT Specialist',
      'experience': '7 years',
      'rating': '4.4',
      'hospital': 'ENT Care Clinic',
      'fee': '350',
      'available': 'Today'
    },
    {
      'name': 'Dr. Jennifer Lee',
      'specialty': 'Gynecologist',
      'experience': '13 years',
      'rating': '4.8',
      'hospital': 'Women\'s Health Center',
      'fee': '550',
      'available': 'Thu'
    },
    {
      'name': 'Dr. John Smith',
      'specialty': 'Psychiatrist',
      'experience': '10 years',
      'rating': '4.6',
      'hospital': 'Mind & Wellness Clinic',
      'fee': '700',
      'available': 'Mon'
    },
    {
      'name': 'Dr. Anna White',
      'specialty': 'Cardiologist',
      'experience': '9 years',
      'rating': '4.5',
      'hospital': 'City Heart Center',
      'fee': '500',
      'available': 'Tomorrow'
    },
    {
      'name': 'Dr. Tom Harris',
      'specialty': 'General Physician',
      'experience': '6 years',
      'rating': '4.3',
      'hospital': 'MediQ General Hospital',
      'fee': '250',
      'available': 'Today'
    },
  ];

  List<Map<String, String>> get _filteredDoctors {
    final query = _searchController.text.toLowerCase().trim();
    return _allDoctors.where((d) {
      final matchesSpecialty =
          _selectedSpecialty == 'All' || d['specialty'] == _selectedSpecialty;
      final matchesQuery = query.isEmpty ||
          d['name']!.toLowerCase().contains(query) ||
          d['specialty']!.toLowerCase().contains(query) ||
          d['hospital']!.toLowerCase().contains(query);
      return matchesSpecialty && matchesQuery;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Find Doctors')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name, specialty, or hospital...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        })
                    : null,
                filled: true,
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _specialties.length,
              itemBuilder: (context, index) {
                final specialty = _specialties[index];
                final isSelected = _selectedSpecialty == specialty;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(specialty),
                    selected: isSelected,
                    onSelected: (_) =>
                        setState(() => _selectedSpecialty = specialty),
                    selectedColor: AppTheme.primaryColor,
                    labelStyle: TextStyle(
                        color:
                            isSelected ? Colors.white : AppTheme.textPrimary),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _filteredDoctors.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off,
                            size: 64,
                            color:
                                AppTheme.textSecondary.withValues(alpha: 0.5)),
                        const SizedBox(height: 16),
                        Text('No doctors found',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: AppTheme.textSecondary)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredDoctors.length,
                    itemBuilder: (context, index) {
                      final doctor = _filteredDoctors[index];
                      return _DoctorCard(
                        doctor: doctor,
                        onTap: () => context.push('/patient/book-appointment',
                            extra: doctor),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final Map<String, String> doctor;
  final VoidCallback onTap;

  const _DoctorCard({required this.doctor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor:
                        AppTheme.primaryColor.withValues(alpha: 0.1),
                    child: Text(
                      doctor['name']!.split(' ').last[0],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doctor['name']!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 2),
                        Text(doctor['specialty']!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppTheme.textSecondary)),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.successColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star,
                            size: 14, color: AppTheme.warningColor),
                        const SizedBox(width: 4),
                        Text(doctor['rating']!,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.work_history,
                      size: 16, color: AppTheme.textSecondary),
                  const SizedBox(width: 6),
                  Text('${doctor['experience']} experience',
                      style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(width: 20),
                  Icon(Icons.business, size: 16, color: AppTheme.textSecondary),
                  const SizedBox(width: 6),
                  Expanded(
                      child: Text(doctor['hospital']!,
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.currency_rupee,
                      size: 16, color: AppTheme.textSecondary),
                  const SizedBox(width: 6),
                  Text('₹${doctor['fee']}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time,
                            size: 14, color: AppTheme.primaryColor),
                        const SizedBox(width: 4),
                        Text('Available: ${doctor['available']}',
                            style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
