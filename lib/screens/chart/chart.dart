import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:coin_track/modules/economia_awesome_api/services/get_currency_history.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({
    super.key,
    required this.fromSymbol,
    required this.toSymbol,
    required this.currentRate,
  });

  final String fromSymbol;
  final String toSymbol;
  final double currentRate;

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  late List<FlSpot> chartData;
  late List<String> xAxisLabels;
  final CurrencyHistoryService _currencyHistoryService =
      CurrencyHistoryService();

  @override
  void initState() {
    super.initState();
    chartData = [];
    xAxisLabels = [];
    _loadChartData();
  }

  Future<void> _loadChartData() async {
    final now = DateTime.now();
    final dateFormat = DateFormat('yyyyMMdd');

    final threeMonthsAgo = dateFormat.format(
      now.subtract(Duration(days: 31 * 3)),
    );

    final twoMonthsAgo = dateFormat.format(
      now.subtract(Duration(days: 31 * 2)),
    );

    final oneMonthAgo = dateFormat.format(now.subtract(Duration(days: 31)));

    try {
      final threeMonthsRate = await _currencyHistoryService.get(
        widget.fromSymbol,
        widget.toSymbol,
        threeMonthsAgo,
        threeMonthsAgo,
      );

      final twoMonthsRate = await _currencyHistoryService.get(
        widget.fromSymbol,
        widget.toSymbol,
        twoMonthsAgo,
        twoMonthsAgo,
      );

      final oneMonthRate = await _currencyHistoryService.get(
        widget.fromSymbol,
        widget.toSymbol,
        oneMonthAgo,
        oneMonthAgo,
      );

      setState(() {
        chartData = [
          FlSpot(0, threeMonthsRate),
          FlSpot(1, twoMonthsRate),
          FlSpot(2, oneMonthRate),
          FlSpot(3, widget.currentRate),
        ];

        xAxisLabels = [
          DateFormat.MMM().format(DateTime.parse(threeMonthsAgo)),
          DateFormat.MMM().format(DateTime.parse(twoMonthsAgo)),
          DateFormat.MMM().format(DateTime.parse(oneMonthAgo)),
          DateFormat.MMM().format(now),
        ];
      });
    } catch (e) {
      print("Erro ao carregar os dados: $e");
    }
  }

  LineChartData buildLineChartData() {
    final minY = chartData.map((spot) => spot.y).reduce(min);
    final maxY = chartData.map((spot) => spot.y).reduce(max);

    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              final label = xAxisLabels[value.toInt()];
              return SideTitleWidget(
                meta: meta,
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
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
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.white24, width: 1),
        ),
      ),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((touchedSpot) {
              return LineTooltipItem(
                touchedSpot.y.toStringAsFixed(4),
                const TextStyle(color: Color(0xFFF0B90B), fontSize: 12),
              );
            }).toList();
          },
        ),
        handleBuiltInTouches: true,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: chartData,
          isCurved: true,
          curveSmoothness: 0.2,
          color: Color(0xFFF0B90B),
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Color(0xFFF0B90B).withOpacity(0.4),
                Color(0xFFF0B90B).withOpacity(0.0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
      minY: minY - 1,
      maxY: maxY + 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child:
            chartData.isNotEmpty
                ? LineChart(buildLineChartData())
                : Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    backgroundColor: Colors.black87,
                    strokeWidth: 2,
                  ),
                ),
      ),
    );
  }
}
