import 'package:flutter_dotenv/flutter_dotenv.dart';

final String exchangeRateAPIBaseURL =
    'https://v6.exchangerate-api.com/v6/${dotenv.env['EXCHANGE_RATE_API_KEY']}';
