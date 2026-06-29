import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../shared/theme/app_theme.dart';

class PatientReportsScreen extends StatelessWidget {
  const PatientReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Health Reports'),
          bottom: const TabBar(
            tabs: [Tab(text: 'Overview'), Tab(text: 'Reports')],
          ),
        ),
        body: TabBarView(
          children: [
            _OverviewTab(),
            _ReportsTab(),
          ],
        ),
      ),
    );
  }
}

class _OverviewTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your Vitals',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _VitalCard(
                  icon: Icons.favorite,
                  label: 'Blood Pressure',
                  value: '120/80',
                  unit: 'mmHg',
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _VitalCard(
                  icon: Icons.monitor_heart,
                  label: 'Heart Rate',
                  value: '72',
                  unit: 'bpm',
                  color: AppTheme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _VitalCard(
                  icon: Icons.bloodtype,
                  label: 'Blood Sugar',
                  value: '95',
                  unit: 'mg/dL',
                  color: AppTheme.warningColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _VitalCard(
                  icon: Icons.monitor_weight,
                  label: 'Cholesterol',
                  value: '180',
                  unit: 'mg/dL',
                  color: AppTheme.secondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('Blood Pressure Trend',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: _BloodPressureChart(),
          ),
          const SizedBox(height: 24),
          Text('Blood Sugar Trend',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: _BloodSugarChart(),
          ),
        ],
      ),
    );
  }
}

class _ReportsTab extends StatelessWidget {
  final List<Map<String, String>> reports = const [
    {
      'name': 'Complete Blood Count',
      'date': 'Jan 15, 2024',
      'type': 'Lab Report',
      'status': 'Ready'
    },
    {
      'name': 'Chest X-Ray Report',
      'date': 'Jan 10, 2024',
      'type': 'Radiology',
      'status': 'Ready'
    },
    {
      'name': 'MRI Brain Scan',
      'date': 'Dec 28, 2023',
      'type': 'Radiology',
      'status': 'Processing'
    },
    {
      'name': 'Urinalysis Results',
      'date': 'Dec 20, 2023',
      'type': 'Lab Report',
      'status': 'Ready'
    },
    {
      'name': 'Lipid Profile',
      'date': 'Nov 15, 2023',
      'type': 'Lab Report',
      'status': 'Ready'
    },
    {
      'name': 'Thyroid Function Test',
      'date': 'Nov 10, 2023',
      'type': 'Lab Report',
      'status': 'Ready'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: reports.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final report = reports[index];
        return Card(
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                  report['type'] == 'Lab Report' ? Icons.biotech : Icons.image,
                  color: AppTheme.primaryColor),
            ),
            title: Text(report['name']!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${report['date']} • ${report['type']}'),
                const SizedBox(height: 4),
                Chip(
                  label: Text(report['status']!,
                      style: const TextStyle(fontSize: 12)),
                  backgroundColor: report['status'] == 'Ready'
                      ? AppTheme.successColor.withValues(alpha: 0.2)
                      : AppTheme.warningColor.withValues(alpha: 0.2),
                  labelStyle: TextStyle(
                      color: report['status'] == 'Ready'
                          ? AppTheme.successColor
                          : AppTheme.warningColor),
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {},
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}

class _VitalCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final Color color;

  const _VitalCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

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
                Icon(icon, color: color, size: 22),
                const Spacer(),
                Text(value,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold, color: color)),
              ],
            ),
            const SizedBox(height: 8),
            Text(label,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppTheme.textSecondary)),
            Text(unit,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppTheme.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class _BloodPressureChart extends StatelessWidget {
  final List<_ChartData> systolicData = const [
    _ChartData(0, 128),
    _ChartData(1, 132),
    _ChartData(2, 125),
    _ChartData(3, 130),
    _ChartData(4, 122),
    _ChartData(5, 120),
  ];
  final List<_ChartData> diastolicData = const [
    _ChartData(0, 82),
    _ChartData(1, 85),
    _ChartData(2, 80),
    _ChartData(3, 83),
    _ChartData(4, 79),
    _ChartData(5, 80),
  ];
  final List<String> months = const ['Aug', 'Sep', 'Oct', 'Nov', 'Dec', 'Jan'];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 20, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _LegendDot(Colors.red, 'Systolic'),
                const SizedBox(width: 16),
                _LegendDot(Colors.blue, 'Diastolic'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 20,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.withValues(alpha: 0.15),
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        interval: 20,
                        getTitlesWidget: (value, meta) => Text(
                          '${value.toInt()}',
                          style: TextStyle(
                              fontSize: 10, color: AppTheme.textSecondary),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 24,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final i = value.toInt();
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              i >= 0 && i < months.length ? months[i] : '',
                              style: TextStyle(
                                  fontSize: 10, color: AppTheme.textSecondary),
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  minY: 60,
                  maxY: 160,
                  lineBarsData: [
                    LineChartBarData(
                      spots: systolicData
                          .map((d) => FlSpot(d.x.toDouble(), d.y.toDouble()))
                          .toList(),
                      isCurved: true,
                      color: Colors.red,
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                                radius: 4, color: Colors.red, strokeWidth: 0),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.red.withValues(alpha: 0.08),
                      ),
                    ),
                    LineChartBarData(
                      spots: diastolicData
                          .map((d) => FlSpot(d.x.toDouble(), d.y.toDouble()))
                          .toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                                radius: 4, color: Colors.blue, strokeWidth: 0),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blue.withValues(alpha: 0.08),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BloodSugarChart extends StatelessWidget {
  final List<_ChartData> fastingData = const [
    _ChartData(0, 98),
    _ChartData(1, 102),
    _ChartData(2, 95),
    _ChartData(3, 100),
    _ChartData(4, 93),
    _ChartData(5, 95),
  ];
  final List<String> months = const ['Aug', 'Sep', 'Oct', 'Nov', 'Dec', 'Jan'];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 20, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _LegendDot(AppTheme.warningColor, 'Fasting Blood Sugar'),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 20,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.withValues(alpha: 0.15),
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 20,
                        getTitlesWidget: (value, meta) => Text(
                          '${value.toInt()}',
                          style: TextStyle(
                              fontSize: 10, color: AppTheme.textSecondary),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 24,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final i = value.toInt();
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              i >= 0 && i < months.length ? months[i] : '',
                              style: TextStyle(
                                  fontSize: 10, color: AppTheme.textSecondary),
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  minY: 60,
                  maxY: 140,
                  lineBarsData: [
                    LineChartBarData(
                      spots: fastingData
                          .map((d) => FlSpot(d.x.toDouble(), d.y.toDouble()))
                          .toList(),
                      isCurved: true,
                      color: AppTheme.warningColor,
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                                radius: 4,
                                color: AppTheme.warningColor,
                                strokeWidth: 0),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppTheme.warningColor.withValues(alpha: 0.08),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  final int x;
  final int y;
  const _ChartData(this.x, this.y);
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot(this.color, this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label,
            style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
      ],
    );
  }
}
