import 'package:coin_track/modules/conversions/models/conversion.dart';
import 'package:flutter/material.dart';

class ConversionCard extends StatelessWidget {
  final Conversion item;
  final VoidCallback onDismissed;

  const ConversionCard({
    super.key,
    required this.item,
    required this.onDismissed,
  });

  Future<bool?> _showDeleteConfirmation(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text(
            'Confirmar exclusão',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Tem certeza que deseja excluir esta conversão?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text(
                'Excluir',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id.toString()),
      direction: DismissDirection.endToStart,
      background: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Card(
          color: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20.0),
            child: const Icon(Icons.delete, color: Colors.white, size: 30),
          ),
        ),
      ),
      confirmDismiss: (direction) async {
        final bool? confirmed = await _showDeleteConfirmation(context);
        return confirmed ?? false;
      },
      onDismissed: (direction) {
        onDismissed.call();
      },
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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
      ),
    );
  }
}
