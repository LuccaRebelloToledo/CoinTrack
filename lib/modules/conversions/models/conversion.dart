class Conversion {
  final int? id;
  final String fromSymbol;
  final String toSymbol;
  double rate;
  double amount;
  double result;

  Conversion({
    this.id,
    required this.fromSymbol,
    required this.toSymbol,
    required this.rate,
    required this.amount,
    required this.result,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'from_symbol': fromSymbol,
      'to_symbol': toSymbol,
      'rate': rate,
      'amount': amount,
      'result': result,
    };
  }

  factory Conversion.fromMap(Map<String, dynamic> map) {
    return Conversion(
      id: map['id'],
      fromSymbol: map['from_symbol'],
      toSymbol: map['to_symbol'],
      rate: map['rate'],
      amount: map['amount'],
      result: map['result'],
    );
  }
}
