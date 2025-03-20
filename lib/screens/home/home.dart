import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/charts/charts.dart';
import '../../screens/conversion/conversion.dart';
import '../../screens/welcome/welcome.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var isLoading = false.obs;

  void onTabTapped(int index) async {
    if (index == currentIndex.value) return;

    isLoading.value = true;
    await Future.delayed(Duration(milliseconds: 500));
    currentIndex.value = index;
    isLoading.value = false;
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    final List<Widget> children = [
      WelcomeScreen(),
      ConversionScreen(),
      ChartsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121212),
        title: Text('CoinTrack', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        return FadeTransition(
          opacity: AlwaysStoppedAnimation<double>(
            homeController.isLoading.value ? 0.5 : 1.0,
          ),
          child: children[homeController.currentIndex.value],
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          backgroundColor: Color(0xFF1E1E1E),
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white70,
          currentIndex: homeController.currentIndex.value,
          onTap: homeController.onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: Hero(tag: 'home-icon', child: Icon(Icons.home)),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Hero(tag: 'conversion-icon', child: Icon(Icons.swap_horiz)),
              label: 'Conversão',
            ),
            BottomNavigationBarItem(
              icon: Hero(tag: 'charts-icon', child: Icon(Icons.bar_chart)),
              label: 'Gráficos',
            ),
          ],
        );
      }),
    );
  }
}
