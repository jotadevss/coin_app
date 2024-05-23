import 'package:asp/asp.dart';
import 'package:coin_app/app/interactor/atoms/currency_atoms.dart';
import 'package:coin_app/app/interactor/models/currency.dart';
import 'package:coin_app/app/shared/theme.dart';
import 'package:coin_app/app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CurrencyBottomSheet extends StatefulWidget {
  const CurrencyBottomSheet({
    super.key,
    required this.currencies,
  });

  final List<Currency> currencies;

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
          Expanded(
            child: ListView.builder(
              itemCount: (searchCurrencyResult.isNotEmpty || controller.text.isNotEmpty) ? searchCurrencyResult.length : widget.currencies.length,
              itemBuilder: (context, index) {
                final currencyList = (searchCurrencyResult.isNotEmpty || controller.text.isNotEmpty) ? searchCurrencyResult : widget.currencies;
                final currency = currencyList[index];

                return ListTile(
                  onTap: () {},
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
