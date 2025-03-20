import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key, required this.currency});

  final String currency;

  List<FlSpot> getChartData() {
    final now = DateTime.now();
    final random = Random();
    return List.generate(12, (index) {
      final month = now.subtract(Duration(days: 30 * index));
      final baseValue = 5.0 + (month.month % 3) * 0.2;
      final variation = random.nextDouble() * 2 - 1;
      final value = (baseValue + variation).clamp(4.0, 6.0);
      return FlSpot(11 - index.toDouble(), value);
    });
  }

  List<String> getXAxisLabels() {
    final now = DateTime.now();
    final dateFormat = DateFormat('MMM');
    return List.generate(12, (index) {
      final month = now.subtract(Duration(days: 30 * index));
      return dateFormat.format(month);
    }).reversed.toList();
  }

  String getXAxisLabel(int index) {
    final labels = getXAxisLabels();
    return (index >= 0 && index < labels.length) ? labels[index] : '';
  }

  LineChartData buildLineChartData() {
    final data = getChartData();
    final minY = data.map((spot) => spot.y).reduce(min);
    final maxY = data.map((spot) => spot.y).reduce(max);

    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return Text(
                getXAxisLabel(value.toInt()),
                style: const TextStyle(fontSize: 10, color: Colors.white),
              );
            },
          ),
        ),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toStringAsFixed(1),
                style: const TextStyle(fontSize: 10, color: Colors.white),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: data,
          isCurved: false,
          color: Colors.yellow,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: true, color: Colors.yellow),
        ),
      ],
      minY: minY,
      maxY: maxY,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(buildLineChartData()),
      ),
    );
  }
}
