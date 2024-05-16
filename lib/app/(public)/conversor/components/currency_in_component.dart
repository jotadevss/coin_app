import 'package:asp/asp.dart';
import 'package:coin_app/app/(public)/conversor/components/select_currency_component.dart';
import 'package:coin_app/app/interactor/atoms/currency_atoms.dart';
import 'package:coin_app/app/interactor/models/currency.dart';
import 'package:coin_app/app/interactor/states/currency_state.dart';
import 'package:coin_app/app/shared/theme.dart';
import 'package:flutter/material.dart';

class CurrencyIn extends StatelessWidget {
  const CurrencyIn({super.key, required this.showCurrencyBottomSheet});

  final void Function(List<Currency>) showCurrencyBottomSheet;

  @override
  Widget build(BuildContext context) {
    final currencyState$ = context.select(() => currencyState.value);

    late Widget selectCurrencyComponent;

    if (currencyState$ is InitCurrencyState) {
      selectCurrencyComponent = SelectCurrency(
        label: "De",
        title: "Selecione uma moeda",
        subtitle: "Moeda primária",
        iconPath: "lib/assets/icons/arrow-in.svg",
        onTap: () {},
        onClear: () {},
      );
    }

    if (currencyState$ is EmptyCurrencyState) {
      selectCurrencyComponent = SelectCurrency(
        label: "De",
        title: "Selecione uma moeda",
        subtitle: "Moeda primária",
        iconPath: "lib/assets/icons/arrow-in.svg",
        onTap: () => showCurrencyBottomSheet(currencyState$.allCurrencies),
        onClear: () {},
      );
    }

    if (currencyState$ is CurrencyInSelectedState) {
      selectCurrencyComponent = SelectCurrency(
        label: "De",
        title: "Selecione uma moeda",
        subtitle: "Moeda primária",
        iconPath: AppStyle.getCurrencyFlag(currencyState$.currencyIn.code),
        onTap: () => showCurrencyBottomSheet(currencyState$.allCurrencies),
        onClear: () {},
      );
    }

    if (currencyState$ is CurrencyOutSelectedState) {
      selectCurrencyComponent = SelectCurrency(
        label: "De",
        title: "Selecione uma moeda",
        subtitle: "Moeda primária",
        iconPath: "lib/assets/icons/arrow-in.svg",
        onTap: () => showCurrencyBottomSheet(currencyState$.allCurrencies),
        onClear: () {},
      );
    }

    if (currencyState$ is SuccessCurrencyState) {
      selectCurrencyComponent = SelectCurrency(
        label: "De",
        title: "Selecione uma moeda",
        subtitle: "Moeda primária",
        iconPath: AppStyle.getCurrencyFlag(currencyState$.currencyIn.code),
        onTap: () => showCurrencyBottomSheet(currencyState$.availableCurrenciesIn),
        onClear: () {},
      );
    }

    return selectCurrencyComponent;
  }
}
