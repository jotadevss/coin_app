import 'package:asp/asp.dart';
import 'package:coin_app/app/(public)/conversor/components/filled_button_component.dart';
import 'package:coin_app/app/(public)/conversor/components/flip_currencies_component.dart';
import 'package:coin_app/app/(public)/conversor/components/input_value_form_component.dart';
import 'package:coin_app/app/(public)/conversor/components/main_app_bar_component.dart';
import 'package:coin_app/app/(public)/conversor/components/quotation_value_component.dart';
import 'package:coin_app/app/(public)/conversor/components/select_currency_component.dart';
import 'package:coin_app/app/(public)/conversor/components/sheets/currency_bottom_sheet.dart';
import 'package:coin_app/app/interactor/actions/conversor_actions.dart';
import 'package:coin_app/app/interactor/atoms/conversor_atoms.dart';
import 'package:coin_app/app/interactor/dto/quote_info_dto.dart';
import 'package:coin_app/app/interactor/models/currency.dart';
import 'package:coin_app/app/shared/theme.dart';
import 'package:coin_app/app/size_config.dart';
import 'package:coin_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routefly/routefly.dart';

class ConversorPage extends StatefulWidget {
  const ConversorPage({super.key});

  @override
  State<ConversorPage> createState() => _ConversorPageState();
}

class _ConversorPageState extends State<ConversorPage> {
  @override
  void initState() {
    super.initState();
    conversorAction.setValue(FetchAllCurrenciesAction1());
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void showCurrencyBottomSheet(Currency? currencyTarget, {required List<Currency> allCurrencies, required void Function(Currency) onTap}) {
    final actualContext = _scaffoldKey.currentContext!;
    SizeConfig().init(actualContext);

    filteredCurrencyBySearchInputState.value.clear();

    final availableCurrencies = [...allCurrencies];
    availableCurrencies.removeWhere((c) => c.code == currencyTarget?.code);

    showModalBottomSheet(
      context: actualContext,
      elevation: 0,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: SizeConfig.screenHeight! / 1.2,
        minWidth: SizeConfig.screenWidth!,
      ),
      builder: (context) => CurrencyBottomSheet(
        currencies: availableCurrencies,
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // States
    final conversorState$ = context.select(() => conversorState.value);
    final inputValue$ = context.select(() => inputValueState.value);

    final Widget? body = conversorState$.when(
      init: (state) => null,
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
                onTap: () => showCurrencyBottomSheet(
                  state.currencyOut,
                  onTap: (currency) => conversorAction.setValue(ChangeCurrencyInAction(currencyIn: currency)),
                  allCurrencies: state.allCurrencies,
                ),
                onClear: null,
              ),
            ),
            InputValueForm(prefixCurrencyInCode: state.currencyIn.code),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: FlipCurrencies(
                onPressed: () {
                  conversorAction.setValue(FlipCurrenciesAction());
                },
                enable: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: SelectCurrency(
                label: "Para",
                title: state.currencyOut.name,
                subtitle: state.currencyOut.code,
                iconPath: AppStyle.getCurrencyFlag(state.currencyOut.code),
                onTap: () => showCurrencyBottomSheet(
                  state.currencyIn,
                  onTap: (currency) => conversorAction.setValue(ChangeCurrencyOutAction(currencyOut: currency)),
                  allCurrencies: state.allCurrencies,
                ),
                onClear: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 28),
              child: QuotationValue(
                codeIn: state.currencyIn.code,
                codeOut: state.currencyOut.code,
                rate: state.rate,
                rateValue: state.rateValue,
                input: inputValue$,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 10),
              child: CustomFilledButton(onPressed: () {
                Routefly.push(routePaths.variation, arguments: QuoteInfoDTO(quote: state.quote));
              }),
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
      loading: (state) {
        return Column(
          children: [
            const MainAppBar(),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              color: AppStyle.kPrimaryColor,
              backgroundColor: AppStyle.kGrayFontColor.withOpacity(0.1),
            ),
          ],
        );
      },
      error: (state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: SizeConfig.screenHeight! / 3.5),
              CircleAvatar(
                radius: 24,
                backgroundColor: AppStyle.kGrayFontColor.withOpacity(0.1),
                child: SvgPicture.asset(
                  "lib/assets/icons/search-not-found.svg",
                  width: 28,
                ),
              ).animate().scale(duration: const Duration(milliseconds: 350)),
              const SizedBox(height: 12),
              const Text(
                "Não encontrado!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ).animate().fadeIn(),
              const Text(
                "Não foi possível encontrar um câmbio disponível para a moeda selecionada",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppStyle.kGrayFontColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ).animate().fadeIn(),
              const SizedBox(height: 18),
              OutlinedButton(
                onPressed: () {
                  conversorAction.setValue(SetDefaultValuesAction());
                },
                style: ButtonStyle(
                  side: const MaterialStatePropertyAll(BorderSide(color: AppStyle.kPrimaryColor)),
                  overlayColor: MaterialStatePropertyAll(AppStyle.kPrimaryColor.withOpacity(0.1)),
                ),
                child: const Text(
                  "Voltar para Início",
                  style: TextStyle(
                    color: AppStyle.kPrimaryColor,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
        );
      },
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
