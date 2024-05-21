import 'package:asp/asp.dart';
import 'package:coin_app/app/(public)/conversor/components/filled_button_component.dart';
import 'package:coin_app/app/(public)/conversor/components/flip_currencies_component.dart';
import 'package:coin_app/app/(public)/conversor/components/input_value_form_component.dart';
import 'package:coin_app/app/(public)/conversor/components/main_app_bar_component.dart';
import 'package:coin_app/app/(public)/conversor/components/quotation_value_component.dart';
import 'package:coin_app/app/(public)/conversor/components/select_currency_component.dart';
import 'package:coin_app/app/(public)/conversor/components/sheets/currency_bottom_sheet.dart';
import 'package:coin_app/app/(public)/conversor/components/underline_text_button_component.dart';
import 'package:coin_app/app/interactor/atoms/currency_atoms.dart';
import 'package:coin_app/app/interactor/models/currency.dart';
import 'package:coin_app/app/shared/theme.dart';
import 'package:coin_app/app/size_config.dart';
import 'package:flutter/material.dart';

class ConversorPage extends StatefulWidget {
  const ConversorPage({super.key});

  @override
  State<ConversorPage> createState() => _ConversorPageState();
}

class _ConversorPageState extends State<ConversorPage> {
  @override
  void initState() {
    super.initState();
    fetchAllCurrenciesAction.call();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void showCurrencyBottomSheet(List<Currency> allCurrencies) {
    final actualContext = _scaffoldKey.currentContext!;
    SizeConfig().init(actualContext);

    showModalBottomSheet(
      context: actualContext,
      elevation: 0,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: SizeConfig.screenHeight! / 1.2,
        minWidth: SizeConfig.screenWidth!,
      ),
      builder: (context) => CurrencyBottomSheet(currencies: allCurrencies),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currencyState$ = context.select(() => currencyState.value);

    final Widget? body = currencyState$.when(
      currencyIn: (state) {
        return Column(
          children: [
            const MainAppBar(),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 0),
              child: SelectCurrency(
                label: "De",
                title: state.currencyIn.name,
                subtitle: state.currencyIn.code,
                iconPath: AppStyle.getCurrencyFlag(state.currencyIn.code),
                onTap: () => showCurrencyBottomSheet(state.allCurrencies),
                onClear: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: SelectCurrency(
                label: "Para",
                title: "Selecione uma moeda",
                subtitle: "Moeda secundária",
                iconPath: "lib/assets/icons/arrow-in.svg",
                onTap: () => showCurrencyBottomSheet(state.availableCurrenciesOut),
                onClear: null,
              ),
            ),
          ],
        );
      },
      currencyOut: (state) {
        return Column(
          children: [
            const MainAppBar(),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 0),
              child: SelectCurrency(
                label: "De",
                title: "Selecione uma moeda",
                subtitle: "Moeda primária",
                iconPath: "lib/assets/icons/arrow-in.svg",
                onTap: () => showCurrencyBottomSheet(state.availableCurrenciesIn),
                onClear: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: SelectCurrency(
                label: "Para",
                title: state.currencyOut.name,
                subtitle: state.currencyOut.code,
                iconPath: AppStyle.getCurrencyFlag(state.currencyOut.code),
                onTap: () => showCurrencyBottomSheet(state.allCurrencies),
                onClear: () {},
              ),
            ),
          ],
        );
      },
      init: (state) {
        return Column(
          children: [
            const MainAppBar(),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 0),
              child: SelectCurrency(
                label: "De",
                title: "Selecione uma moeda",
                subtitle: "Moeda primária",
                iconPath: "lib/assets/icons/arrow-in.svg",
                onTap: () => showCurrencyBottomSheet([]),
                onClear: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: SelectCurrency(
                label: "Para",
                title: "Selecione uma moeda",
                subtitle: "Moeda secundária",
                iconPath: "lib/assets/icons/arrow-in.svg",
                onTap: () => showCurrencyBottomSheet([]),
                onClear: null,
              ),
            ),
          ],
        );
      },
      success: (state) {
        return Column(
          children: [
            const MainAppBar(),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 0),
              child: SelectCurrency(
                label: "De",
                title: state.currencyIn.name,
                subtitle: state.currencyIn.code,
                iconPath: AppStyle.getCurrencyFlag(state.currencyIn.code),
                onTap: () => showCurrencyBottomSheet(state.availableCurrenciesIn),
                onClear: () {},
              ),
            ),
            const InputValueForm(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: FlipCurrencies(onPressed: () {}, enable: state.canFlipCurrencies),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: SelectCurrency(
                label: "Para",
                title: state.currencyOut.name,
                subtitle: state.currencyOut.code,
                iconPath: AppStyle.getCurrencyFlag(state.currencyOut.code),
                onTap: () => showCurrencyBottomSheet(state.availableCurrenciesOut),
                onClear: () {},
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 28),
              child: QuotationValue(),
            ),
            UnderlineTextButton(
              title: "Limpar todas moedas selecionadas",
              onPressed: () {},
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
        );
      },
      empty: (state) {
        return Column(
          children: [
            const MainAppBar(),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 0),
              child: SelectCurrency(
                label: "De",
                title: "Selecione uma moeda",
                subtitle: "Moeda primária",
                iconPath: "lib/assets/icons/arrow-in.svg",
                onTap: () => showCurrencyBottomSheet(state.allCurrencies),
                onClear: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: SelectCurrency(
                label: "Para",
                title: "Selecione uma moeda",
                subtitle: "Moeda secundária",
                iconPath: "lib/assets/icons/arrow-in.svg",
                onTap: () => showCurrencyBottomSheet(state.allCurrencies),
                onClear: null,
              ),
            ),
          ],
        );
      },
      error: (state) => null,
    );

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: body,
          ),
        ),
      ),
    );
  }
}
