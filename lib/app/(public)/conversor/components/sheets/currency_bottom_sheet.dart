import 'package:asp/asp.dart';
import 'package:coin_app/app/interactor/atoms/currency_atoms.dart';
import 'package:coin_app/app/interactor/models/currency.dart';
import 'package:coin_app/app/shared/theme.dart';
import 'package:coin_app/app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routefly/routefly.dart';

class CurrencyBottomSheet extends StatefulWidget {
  const CurrencyBottomSheet({
    super.key,
    required this.currencies,
    required this.onTap,
  });

  final List<Currency> currencies;
  final void Function(Currency) onTap;

  @override
  State<CurrencyBottomSheet> createState() => _CurrencyBottomSheetState();
}

class _CurrencyBottomSheetState extends State<CurrencyBottomSheet> {
  final TextEditingController controller = TextEditingController(text: inputSearchCurrencyText.value);

  @override
  Widget build(BuildContext context) {
    final searchCurrencyResult = context.select(() => searchCurrencyResultState.value);

    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "Moedas disponíveis",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextField(
            controller: controller,
            onChanged: (text) {
              inputSearchCurrencyText.setValue(text);
              filterCurrencyStringSearchAction.setValue(widget.currencies);
            },
            style: const TextStyle(
              fontSize: 16,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              hintText: "Procurar moedas",
              hintStyle: TextStyle(
                fontSize: 16,
                height: 0,
                color: AppStyle.kGrayFontColor.withOpacity(0.3),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SvgPicture.asset(
                  "lib/assets/icons/search.svg",
                  width: 18,
                ),
              ),
              filled: true,
              fillColor: AppStyle.kGrayFontColor.withOpacity(0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (widget.currencies.isEmpty)
            SizedBox(
              width: SizeConfig.screenWidth! / 1.2,
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight! / 8),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppStyle.kGrayFontColor.withOpacity(0.1),
                    child: SvgPicture.asset(
                      "lib/assets/icons/search-not-found.svg",
                      width: 28,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Não encontrado!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    "Não foi possível encontrar um câmbio disponível para a moeda selecionada",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppStyle.kGrayFontColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 18),
                  OutlinedButton(
                    onPressed: () {
                      Routefly.pop(context);
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
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: (searchCurrencyResult.isNotEmpty || controller.text.isNotEmpty) ? searchCurrencyResult.length : widget.currencies.length,
                itemBuilder: (context, index) {
                  final currencyList = (searchCurrencyResult.isNotEmpty || controller.text.isNotEmpty) ? searchCurrencyResult : widget.currencies;
                  final currency = currencyList[index];

                  return ListTile(
                    onTap: () {
                      widget.onTap(currency);
                    },
                    leading: CircleAvatar(
                      radius: 20,
                      child: SvgPicture.asset(
                        AppStyle.getCurrencyFlag(currency.code),
                        width: 40,
                      ),
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    title: Text(
                      currency.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      currency.code,
                      style: TextStyle(
                        color: AppStyle.kGrayFontColor.withOpacity(0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
