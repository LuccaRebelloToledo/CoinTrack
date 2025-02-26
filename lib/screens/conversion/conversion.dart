import 'package:coin_track/widgets/scaffold/custom_scaffold.dart';
import 'package:flutter/material.dart';

class ConversionScreen extends StatelessWidget {
  const ConversionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Text(
          'Tela de Conversão',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
