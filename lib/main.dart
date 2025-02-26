import 'package:country_flags/country_flags.dart';
import 'package:d4_6_10/currency_model.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Currency Converter",
                    style: GoogleFonts.roboto(
                      color: Color(0xff1F2261),
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                    ),
                  ),
                ),
                Text(
                  "Check live rates, set rate alerts, receive notifications and more.",
                  style: GoogleFonts.roboto(
                    color: Color(0xff808080),
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          DropdownButton<CurrencyModel>(
                            underline: SizedBox.shrink(),
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
                                        SizedBox(width: 8),
                                        Text(
                                          model.currencyCode,
                                          style: GoogleFonts.roboto(
                                            color: Color(0xff26278D),
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              cursorColor: Colors.black,
                              controller: inputController,
                              focusNode: focusNode,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Color(0xff3C3C3C),
                                fontWeight: FontWeight.w600,
                              ),
                              onTapOutside: (val) {
                                focusNode.unfocus();
                                convert();
                              },
                              onSubmitted: (val) {
                                convert();
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffEFEFEF),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          DropdownButton<CurrencyModel>(
                            underline: SizedBox.shrink(),
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
                                        SizedBox(width: 8),
                                        Text(
                                          model.currencyCode,
                                          style: GoogleFonts.roboto(
                                            color: Color(0xff26278D),
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xffEFEFEF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                result.toStringAsFixed(2),
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  color: Color(0xff3C3C3C),
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.end,
                              ),
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
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Color(0xff9B9B9B),
                  ),
                ),
                Text(
                  "1 ${inputCurrency.currencyCode} = $oneCost ${outputCurrency.currencyCode}",
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
