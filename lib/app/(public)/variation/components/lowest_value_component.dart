import 'package:coin_app/app/shared/formatters/currency_formatter.dart';
import 'package:coin_app/app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LowestValue extends StatelessWidget {
  const LowestValue({
    super.key,
    required this.value,
    required this.suffix,
  });

  final double value;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: AppStyle.kGrayFontColor.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppStyle.kPrimaryColor,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SvgPicture.asset(
                  "lib/assets/icons/arrow-trend-down.svg",
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: 15,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Menor valor hoje",
                style: TextStyle(
                  fontSize: 14,
                  color: AppStyle.kPrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 1),
              FittedBox(
                child: Text(
                  "${CurrencyFormatter.format((value * 100).toString())} $suffix",
                  style: const TextStyle(
                    fontSize: 26,
                    color: AppStyle.kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
