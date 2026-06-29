import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../shared/theme/app_theme.dart';
import '../../shared/widgets/custom_button.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final _reasonController = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  String _selectedTime = '10:00 AM';
  String _selectedType = 'In-Person';
  bool _isBooking = false;

  final List<String> _timeSlots = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
    '04:00 PM',
    '04:30 PM',
    '05:00 PM',
  ];

  final List<String> _appointmentTypes = [
    'In-Person',
    'Video Consultation',
    'Phone Consultation'
  ];

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final doctor =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    if (doctor == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Book Appointment')),
        body: const Center(child: Text('No doctor selected')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor:
                          AppTheme.primaryColor.withValues(alpha: 0.1),
                      child: Text(
                        doctor['name']!.split(' ').last[0],
                        style: TextStyle(
                            fontSize: 24,
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
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(doctor['specialty']!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppTheme.textSecondary)),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Icon(Icons.star,
                                  size: 14, color: AppTheme.warningColor),
                              const SizedBox(width: 4),
                              Text('${doctor['rating']}  |  ₹${doctor['fee']}',
                                  style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Select Date',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 14,
                itemBuilder: (context, index) {
                  final date = DateTime.now().add(Duration(days: index + 1));
                  final isSelected = _selectedDate.day == date.day &&
                      _selectedDate.month == date.month &&
                      _selectedDate.year == date.year;
                  final isToday = index == 0;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedDate = date),
                      child: Container(
                        width: 72,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.primaryColor
                              : Theme.of(context).cardTheme.color,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppTheme.primaryColor
                                : Colors.grey[300]!,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('EEE').format(date),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected
                                      ? Colors.white70
                                      : AppTheme.textSecondary),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colors.white
                                      : AppTheme.textPrimary),
                            ),
                            Text(
                              DateFormat('MMM').format(date),
                              style: TextStyle(
                                  fontSize: 11,
                                  color: isSelected
                                      ? Colors.white70
                                      : AppTheme.textSecondary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text('Select Time',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _timeSlots.map((time) {
                final isSelected = _selectedTime == time;
                return ChoiceChip(
                  label: Text(time,
                      style: TextStyle(
                          fontSize: 13,
                          color: isSelected
                              ? Colors.white
                              : AppTheme.textPrimary)),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedTime = time),
                  selectedColor: AppTheme.primaryColor,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text('Appointment Type',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _appointmentTypes.map((type) {
                final isSelected = _selectedType == type;
                return ChoiceChip(
                  label: Text(type,
                      style: TextStyle(
                          fontSize: 13,
                          color: isSelected
                              ? Colors.white
                              : AppTheme.textPrimary)),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedType = type),
                  selectedColor: AppTheme.primaryColor,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text('Reason for Visit',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            TextField(
              controller: _reasonController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Describe your symptoms or reason for visit...',
                filled: true,
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Confirm Booking',
              isLoading: _isBooking,
              onPressed: _isBooking
                  ? null
                  : () async {
                      setState(() => _isBooking = true);
                      await Future.delayed(const Duration(seconds: 1));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Appointment booked successfully!'),
                            backgroundColor: AppTheme.successColor,
                          ),
                        );
                        context.pop();
                      }
                    },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
