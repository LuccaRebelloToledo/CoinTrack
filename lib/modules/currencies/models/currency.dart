class Currency {
  final String symbol;
  final String name;

  Currency({required this.symbol, required this.name});

  Map<String, dynamic> toMap() {
    return {'symbol': symbol, 'name': name};
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(symbol: map['symbol'], name: map['name']);
  }
}
