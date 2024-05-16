import 'package:coin_app/app/(public)/conversor/components/currency_in_component.dart';
import 'package:coin_app/app/(public)/conversor/components/currency_out_component.dart';
import 'package:coin_app/app/(public)/conversor/components/filled_button_component.dart';
import 'package:coin_app/app/(public)/conversor/components/flip_currencies_component.dart';
import 'package:coin_app/app/(public)/conversor/components/input_value_form_component.dart';
import 'package:coin_app/app/(public)/conversor/components/main_app_bar_component.dart';
import 'package:coin_app/app/(public)/conversor/components/quotation_value_component.dart';
import 'package:coin_app/app/interactor/models/currency.dart';
import 'package:coin_app/app/shared/theme.dart';
import 'package:flutter/material.dart';

class ConversorPage extends StatefulWidget {
  const ConversorPage({super.key});

  @override
  State<ConversorPage> createState() => _ConversorPageState();
}

class _ConversorPageState extends State<ConversorPage> {
  void showCurrencyBottomSheet(List<Currency> allCurrencies) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const MainAppBar(),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 0),
                  child: CurrencyIn(showCurrencyBottomSheet: showCurrencyBottomSheet),
                ),
                const InputValueForm(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: FlipCurrencies(onPressed: () {}),
                ),
                CurrencyOut(showCurrencyBottomSheet: showCurrencyBottomSheet),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 28),
                  child: QuotationValue(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 10),
                  child: CustomFilledButton(onPressed: () {}),
                ),
                const Text(
                  "Ultima atualização ás 13:54",
                  style: TextStyle(
                    color: AppStyle.kGrayFontColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
