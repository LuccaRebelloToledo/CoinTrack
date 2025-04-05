import 'package:coin_track/modules/conversions/services/delete_conversions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/add_modal.dart';
import 'components/card.dart';
import 'components/fade_animation.dart';

import 'package:coin_track/screens/chart/chart.dart';
import 'package:coin_track/modules/conversions/models/conversion.dart';
import 'package:coin_track/modules/conversions/services/get_conversions.dart';

class ConversionController extends GetxController {
  final GetConversionsService _getConversionsService = GetConversionsService();
  final DeleteConversionsService _deleteConversionsService =
      DeleteConversionsService();
  var conversionItems = <Conversion>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchConversions();
  }

  Future<void> fetchConversions() async {
    try {
      final conversions = await _getConversionsService.get();
      conversionItems.assignAll(conversions);
    } catch (e) {
      Get.snackbar(
        'Algo deu errado :(',
        'Não foi possível carregar as conversões.',
        icon: const Icon(Icons.error, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16.0),
        borderRadius: 8.0,
      );
    }
  }

  Future<void> deleteConversions(Conversion conversion) async {
    try {
      await _deleteConversionsService.delete(conversion);
      conversionItems.remove(conversion);
      Get.snackbar(
        'Sucesso :)',
        'Conversão excluída com sucesso.',
        icon: const Icon(Icons.check_circle, color: Colors.green),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16.0),
        borderRadius: 8.0,
      );
    } catch (e) {
      Get.snackbar(
        'Algo deu errado :(',
        'Não foi possível excluir a conversão.',
        icon: const Icon(Icons.error, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16.0),
        borderRadius: 8.0,
      );
    }
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
              final item = controller.conversionItems[index];
              return FadeInItem(
                index: index,
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      transition: Transition.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 700),
                      () => ChartScreen(currency: item.toSymbol),
                    );
                  },
                  child: ConversionCard(
                    item: item,
                    onDismissed:
                        () async => {await controller.deleteConversions(item)},
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          final result = await Get.dialog(ConversionAddModal());
          if (result == true) {
            Get.snackbar(
              'Sucesso :)',
              'Conversão salva com sucesso.',
              icon: const Icon(Icons.check_circle, color: Colors.green),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.black87,
              colorText: Colors.white,
              duration: const Duration(seconds: 3),
              margin: const EdgeInsets.all(16.0),
              borderRadius: 8.0,
            );
            controller.fetchConversions();
          }
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
