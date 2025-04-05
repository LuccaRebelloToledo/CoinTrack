import 'package:coin_track/modules/currencies/services/initialize_currencies.dart';
import 'package:coin_track/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';
import 'shared/database/database.dart';

Future<void> initializeCurrencies() async {
  final initializeCurrenciesService = InitializeCurrenciesService();
  await initializeCurrenciesService.initialize();
}

Future<void> initializeDatabase() async {
  final databaseHelper = DatabaseHelper();
  await databaseHelper.initializeDatabase();
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that plugin services are initialized
  await dotenv.load(); // Load environment variables
  await initializeDatabase(); // Initialize the database
  await initializeCurrencies(); // Initialize currencies
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
