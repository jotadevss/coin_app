import 'package:asp/asp.dart';
import 'package:coin_app/app/(public)/variation/components/highest_value_component.dart';
import 'package:coin_app/app/(public)/variation/components/lowest_value_component.dart';
import 'package:coin_app/app/(public)/variation/components/variation_appbar.dart';
import 'package:coin_app/app/(public)/variation/components/variation_line_chart_component.dart';
import 'package:coin_app/app/(public)/variation/components/variation_value_componet.dart';
import 'package:coin_app/app/interactor/actions/variation_actions.dart';
import 'package:coin_app/app/interactor/atoms/variation_atoms.dart';
import 'package:coin_app/app/interactor/dto/quote_info_dto.dart';
import 'package:coin_app/app/interactor/models/combination.dart';
import 'package:coin_app/app/interactor/states/variation_state.dart';
import 'package:coin_app/app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routefly/routefly.dart';

class VariationPage extends StatefulWidget {
  const VariationPage({super.key});

  @override
  State<VariationPage> createState() => _VariationPageState();
}

class _VariationPageState extends State<VariationPage> {
  QuoteInfoDTO quoteInfoFromArgs(BuildContext context) {
    return Routefly.query.arguments as QuoteInfoDTO;
  }

  void fetchVariation() {
    final quoteInfo = quoteInfoFromArgs(context);
    final separateCodes = quoteInfo.quote.codes.split("-");
    final combination = Combination(code: quoteInfo.quote.codes, codeIn: separateCodes[0], codeOut: separateCodes[1]);
    variationAction.setValue(FetchVariationsByDaysAction(days: 15, combination: combination));
  }

  @override
  void initState() {
    fetchVariation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final variationState = context.select(() => variationState$.value);
    final variations$ = context.select(() => reversedVariations);
    final valuesInRangeToChart$ = context.select(() => valuesInRangeToChart);
    final valuesVariationToChart$ = context.select(() => valuesVariationToChart);

    final args = quoteInfoFromArgs(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Column(
              children: [
                VariationAppBar(
                  title: args.quote.codes,
                  subtitle: args.quote.currencies,
                ),
                const SizedBox(height: 32),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppStyle.kGrayFontColor.withOpacity(0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Variação",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4, width: 0),
                            Text(
                              "Variação do valor da moedas ao longo do tempo.",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: AppStyle.kGrayFontColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppStyle.kGrayFontColor.withOpacity(0.1)),
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: const FittedBox(
                              child: Text(
                                "Últimos 15 Dias",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          if (variationState$.value is LoadingVariationState)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppStyle.kPrimaryColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 24, width: 0),
                      (variationState is ErrorVariationState)
                          ? SizedBox(
                              height: 240,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
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
                                      "Não foi possível buscar as variações. Tente Novamente.",
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
                                        fetchVariation();
                                      },
                                      style: ButtonStyle(
                                        side: const MaterialStatePropertyAll(BorderSide(color: AppStyle.kPrimaryColor)),
                                        overlayColor: MaterialStatePropertyAll(AppStyle.kPrimaryColor.withOpacity(0.1)),
                                      ),
                                      child: const Text(
                                        "Buscar valores",
                                        style: TextStyle(
                                          color: AppStyle.kPrimaryColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 8, right: 36, bottom: 24),
                              child: LineChartVariation(
                                variations: variations$,
                                valuesInRangeToChart: valuesInRangeToChart$,
                                valuesVariationToChart: valuesVariationToChart$,
                              ).animate().fade(duration: const Duration(milliseconds: 400)),
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                VariationValues(
                  value: args.quote.value,
                  varBid: args.quote.varBid,
                  pctChange: args.quote.pctChange,
                  suffix: args.quote.codes.split("-").last,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 24),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return (index == 0)
                          ? HighestValue(
                              value: args.quote.high,
                              suffix: args.quote.codes.split("-").last,
                            )
                          : LowestValue(
                              value: args.quote.low,
                              suffix: args.quote.codes.split("-").last,
                            );
                    },
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
