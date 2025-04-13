import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';

import 'package:coin_track/modules/conversions/services/get_and_update_latest_rates.dart';
import 'package:coin_track/modules/currencies/services/initialize_currencies.dart';
import 'shared/database/database.dart';

import 'package:coin_track/screens/home/home.dart';

Future<void> initializeCurrencies() async {
  try {
    final initializeCurrenciesService = InitializeCurrenciesService();
    await initializeCurrenciesService.initialize();
  } catch (e) {
    Get.snackbar(
      'Erro ao inicializar moedas',
      'Houve um problema ao carregar as moedas disponíveis. Por favor, tente novamente mais tarde.',
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

Future<void> initializeDatabase() async {
  try {
    final databaseHelper = DatabaseHelper();
    await databaseHelper.initializeDatabase();
  } catch (e) {
    Get.snackbar(
      'Erro ao inicializar o banco de dados',
      'Houve um problema ao configurar o banco de dados. O aplicativo será fechado.',
      icon: const Icon(Icons.error, color: Colors.red),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16.0),
      borderRadius: 8.0,
    );
    Future.delayed(const Duration(seconds: 3), () {
      Get.back();
    });
  }
}

Future<void> updateConversionsRate() async {
  try {
    final getAndUpdateLatestRatesService = GetAndUpdateLatestRatesService();
    await getAndUpdateLatestRatesService.update();
  } catch (e) {
    Get.snackbar(
      'Erro ao inicializar moedas',
      'Houve um problema ao atualizar a taxa de conversão de suas as moedas. Por favor, tente novamente mais tarde.',
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

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that plugin services are initialized
  await dotenv.load(); // Load environment variables from .env file
  await initializeDatabase(); // Initialize the database
  await initializeCurrencies(); // Initialize currencies
  await updateConversionsRate(); // Update conversions rate
}

Future<void> main() async {
  await initializeApp(); // Initialize the app

  runApp(CoinTrackApp());
}

class CoinTrackApp extends StatelessWidget {
  const CoinTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CoinTrack',
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt', 'BR'),
      theme: ThemeData(
        primaryColor: Color(0xFFF0B90B),
        scaffoldBackgroundColor: Color(0xFF121212),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: HomePage(),
    );
  }
}
