import 'package:equatable/equatable.dart';

class CurrencyModel extends Equatable {
  final String currencyCode; //  usd, uzs
  final String countryCode; //  us,  uz

  // Constructor
  const CurrencyModel({
    required this.currencyCode,
    required this.countryCode,
  });

  @override
  List get props => [currencyCode];
}

List<CurrencyModel> currencies = [
  CurrencyModel(currencyCode: "USD", countryCode: "US"),
  CurrencyModel(currencyCode: "UZS", countryCode: "UZ"),
  CurrencyModel(currencyCode: "EUR", countryCode: "EU"),
  CurrencyModel(currencyCode: "GBP", countryCode: "GB"),
  CurrencyModel(currencyCode: "JPY", countryCode: "JP"),
  CurrencyModel(currencyCode: "CHF", countryCode: "CH"),
  CurrencyModel(currencyCode: "CNY", countryCode: "CN"),
  CurrencyModel(currencyCode: "CAD", countryCode: "CA"),
  CurrencyModel(currencyCode: "AUD", countryCode: "AU"),
  CurrencyModel(currencyCode: "INR", countryCode: "IN"),
  CurrencyModel(currencyCode: "KRW", countryCode: "KR"),
  CurrencyModel(currencyCode: "RUB", countryCode: "RU"),
  CurrencyModel(currencyCode: "KZT", countryCode: "KZ"),
  CurrencyModel(currencyCode: "TRY", countryCode: "TR"),
];
