import 'package:flutter/material.dart';

import '../../screens/charts/charts.dart';
import '../../screens/conversion/conversion.dart';
import '../../screens/welcome/welcome.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool _isLoading = false;

  final List<Widget> _children = [
    WelcomeScreen(),
    ConversionScreen(),
    ChartsScreen(),
  ];

  void _onTabTapped(int index) async {
    if (index == _currentIndex) return;

    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _isLoading = false;
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF121212),
        title: Text('CoinTrack', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          _children[_currentIndex],
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: CircularProgressIndicator(color: Color(0xFFF0B90B)),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF1E1E1E),
        selectedItemColor: Color(0xFFF0B90B),
        unselectedItemColor: Colors.white70,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Conversão',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Gráficos',
          ),
        ],
      ),
    );
  }
}
