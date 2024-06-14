import 'package:coin_app/app/(public)/variation/components/highest_value_component.dart';
import 'package:coin_app/app/(public)/variation/components/lowest_value_component.dart';
import 'package:coin_app/app/(public)/variation/components/variation_appbar.dart';
import 'package:coin_app/app/(public)/variation/components/variation_value_componet.dart';
import 'package:coin_app/app/interactor/dto/quote_info_dto.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class VariationPage extends StatelessWidget {
  const VariationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Routefly.of(context).route.arguments as QuoteInfoDTO;

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
