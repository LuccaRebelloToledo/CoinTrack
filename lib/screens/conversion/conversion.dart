import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'fade_animation.dart';

import 'package:coin_track/screens/chart/chart.dart';

class ConversionController extends GetxController {
  var conversionItems =
      <Map<String, String>>[
        {'currency': 'USD', 'rate': '5.20 BRL'},
        {'currency': 'EUR', 'rate': '5.80 BRL'},
        {'currency': 'GBP', 'rate': '6.10 BRL'},
        {'currency': 'JPY', 'rate': '0.037 BRL'},
        {'currency': 'AUD', 'rate': '3.70 BRL'},
      ].obs;
}

class ConversionScreen extends StatelessWidget {
  ConversionScreen({super.key});

  final ConversionController controller = Get.put(ConversionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.conversionItems.length,
            itemBuilder: (context, index) {
              final item = controller.conversionItems[index];
              return FadeInItem(
                index: index,
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      transition: Transition.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 700),
                      () => ChartScreen(currency: item['currency']!),
                    );
                  },
                  child: ConversionCard(item: item),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ConversionCard extends StatelessWidget {
  final Map<String, String> item;
  const ConversionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item['currency'] ?? '',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              item['rate'] ?? '',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
