import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'fade_animation.dart';

class ConversionController extends GetxController {
  var conversionItems =
      <Map<String, String>>[
        {'currency': 'USD', 'rate': '5.20 BRL'},
        {'currency': 'EUR', 'rate': '5.80 BRL'},
        {'currency': 'GBP', 'rate': '6.10 BRL'},
        {'currency': 'JPY', 'rate': '0.037 BRL'},
        {'currency': 'AUD', 'rate': '3.70 BRL'},
      ].obs;

  void addConversionItem(Map<String, String> item) {
    conversionItems.add(item);
  }

  void removeConversionItem(int index) {
    conversionItems.removeAt(index);
  }
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
              return FadeInItem(
                index: index,
                child: ConversionCard(item: controller.conversionItems[index]),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          controller.addConversionItem({'currency': 'CAD', 'rate': '4.10 BRL'});
        },
        child: const Icon(Icons.add, color: Colors.black),
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
