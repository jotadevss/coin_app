import 'package:coin_app/app/shared/formatters/currency_formatter.dart';
import 'package:coin_app/app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VariationValues extends StatelessWidget {
  const VariationValues({
    super.key,
    required this.value,
    required this.pctChange,
    required this.varBid,
    required this.suffix,
  });

  final double value;
  final double pctChange;
  final double varBid;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppStyle.kGrayFontColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Valor atual",
            style: TextStyle(
              fontSize: 14,
              color: AppStyle.kGrayFontColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${CurrencyFormatter.format((value * 100).toString())} $suffix",
            style: const TextStyle(
              fontSize: 26,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              (pctChange > 0) ? SvgPicture.asset("lib/assets/icons/trend-up.svg") : SvgPicture.asset("lib/assets/icons/trend-down.svg"),
              const SizedBox(width: 12),
              Text(
                "$pctChange%",
                style: TextStyle(
                  fontSize: 14,
                  color: (pctChange > 0) ? const Color(0xff0EAE61) : const Color(0xffD90026),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "$varBid $suffix",
                style: TextStyle(
                  fontSize: 14,
                  color: (pctChange > 0) ? const Color(0xff0EAE61) : const Color(0xffD90026),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
