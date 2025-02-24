import 'package:country_flags/country_flags.dart';
import 'package:d4_6_10/currency_model.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:live_currency_rate/live_currency_rate.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CurrencyModel inputCurrency = currencies[0];
  CurrencyModel outputCurrency = currencies[1];
  double oneCost = 0;
  double result = 0;
  TextEditingController inputController = TextEditingController();
  FocusNode focusNode = FocusNode();

  void convert() async {
    double amount = double.tryParse(inputController.text) ?? 0;
    CurrencyRate rate = await LiveCurrencyRate.convertCurrency(
      inputCurrency.currencyCode,
      outputCurrency.currencyCode,
      1,
    );
    oneCost = rate.result;
    result = oneCost * amount;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Currency Converter",
                  style: TextStyle(fontSize: 28),
                ),
                Text(
                  "Check live rates, set rate alerts, receive notifications and more.",
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          DropdownButton<CurrencyModel>(
                            value: inputCurrency,
                            onChanged: (value) {
                              if (value == null) return;
                              inputCurrency = value;
                              convert();
                            },
                            items: currencies
                                .map(
                                  (model) => DropdownMenuItem<CurrencyModel>(
                                    value: model,
                                    child: Row(
                                      children: [
                                        CountryFlag.fromCountryCode(
                                          model.countryCode,
                                          shape: Circle(),
                                        ),
                                        Text(
                                          model.currencyCode,
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          Expanded(
                            child: TextField(
                              controller: inputController,
                              focusNode: focusNode,
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 20),
                              onTapOutside: (val) {
                                focusNode.unfocus();
                                convert();
                              },
                              onSubmitted: (val) {
                                convert();
                              },
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          DropdownButton<CurrencyModel>(
                            value: outputCurrency,
                            onChanged: (value) {
                              if (value == null) return;
                              outputCurrency = value;
                              convert();
                            },
                            items: currencies
                                .map(
                                  (model) => DropdownMenuItem<CurrencyModel>(
                                    value: model,
                                    child: Row(
                                      children: [
                                        CountryFlag.fromCountryCode(
                                          model.countryCode,
                                          shape: Circle(),
                                        ),
                                        Text(
                                          model.currencyCode,
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          Expanded(
                            child: Text(
                              result.toStringAsFixed(1),
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Indicative Exchange Rate",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
