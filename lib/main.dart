import 'package:coin_track/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CoinTrackApp());
}

class CoinTrackApp extends StatelessWidget {
  const CoinTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
