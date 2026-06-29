import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/custom_button.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctor =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    if (doctor == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Doctor Details')),
        body: const Center(child: Text('Doctor not found')),
      );
    }

    final reviews = _generateReviews(doctor['name']!);

    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Details')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor:
                            AppTheme.primaryColor.withValues(alpha: 0.1),
                        child: Text(
                          doctor['name']!.split(' ').last[0],
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(doctor['name']!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(doctor['specialty']!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppTheme.textSecondary)),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.star,
                                    size: 18, color: AppTheme.warningColor),
                                const SizedBox(width: 4),
                                Text(doctor['rating']!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600)),
                                const SizedBox(width: 4),
                                Text('(${reviews.length} reviews)',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: AppTheme.textSecondary)),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _InfoTile(
                          icon: Icons.work_history,
                          label: 'Experience',
                          value: doctor['experience']!),
                      const Divider(height: 20),
                      _InfoTile(
                          icon: Icons.business,
                          label: 'Hospital',
                          value: doctor['hospital']!),
                      const Divider(height: 20),
                      _InfoTile(
                          icon: Icons.currency_rupee,
                          label: 'Consultation Fee',
                          value: '₹${doctor['fee']}'),
                      const Divider(height: 20),
                      _InfoTile(
                          icon: Icons.access_time,
                          label: 'Next Available',
                          value: doctor['available']!),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomButton(
                text: 'Book Appointment',
                onPressed: () =>
                    context.push('/patient/book-appointment', extra: doctor),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('Patient Reviews',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            ...reviews.map(
              (review) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor:
                                  AppTheme.primaryColor.withValues(alpha: 0.1),
                              child: Text(review['initial']!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primaryColor)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(review['name']!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600)),
                                  Text(review['date']!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: AppTheme.textSecondary)),
                                ],
                              ),
                            ),
                            Row(
                              children: List.generate(5, (i) {
                                final star =
                                    double.tryParse(review['rating']!) ?? 0;
                                return Icon(
                                  i < star ? Icons.star : Icons.star_border,
                                  size: 16,
                                  color: AppTheme.warningColor,
                                );
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(review['comment']!,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  List<Map<String, String>> _generateReviews(String doctorName) {
    final seed = doctorName.hashCode;
    final reviews = [
      {
        'name': 'Alice M.',
        'initial': 'A',
        'rating': '5',
        'date': '2 weeks ago',
        'comment':
            'Excellent doctor! Very thorough examination and explained everything clearly. Highly recommend.',
      },
      {
        'name': 'Bob K.',
        'initial': 'B',
        'rating': '4',
        'date': '1 month ago',
        'comment':
            'Great experience overall. Wait time was reasonable and the staff was friendly.',
      },
      {
        'name': 'Carol S.',
        'initial': 'C',
        'rating': '5',
        'date': '2 months ago',
        'comment':
            'Very knowledgeable and caring. Took time to listen to all my concerns.',
      },
      {
        'name': 'David L.',
        'initial': 'D',
        'rating': '4',
        'date': '3 months ago',
        'comment':
            'Good doctor, prescribed the right treatment. Would visit again.',
      },
    ];
    return reviews;
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppTheme.textSecondary),
        const SizedBox(width: 12),
        Text(label,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppTheme.textSecondary)),
        const Spacer(),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
