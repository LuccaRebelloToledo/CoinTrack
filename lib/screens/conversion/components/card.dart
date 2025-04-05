import 'package:coin_track/modules/conversions/models/conversion.dart';
import 'package:flutter/material.dart';

class ConversionCard extends StatelessWidget {
  final Conversion item;
  const ConversionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item.amount.toStringAsFixed(2)} ${item.fromSymbol} para ${item.toSymbol}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Taxa: ${item.rate.toStringAsFixed(4)}',
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Text(
                'Total convertido: ${item.result.toStringAsFixed(2)} ${item.toSymbol}',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
