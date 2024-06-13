import 'package:coin_app/app/shared/formatters/currency_formatter.dart';
import 'package:coin_app/app/shared/theme.dart';
import 'package:flutter/material.dart';

class QuotationValue extends StatelessWidget {
  const QuotationValue({
    super.key,
    required this.rate,
    required this.rateValue,
    required this.codeIn,
    required this.codeOut,
    required this.input,
  });

  final String codeIn;
  final String codeOut;
  final double rate;
  final double rateValue;
  final double input;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "$codeIn $input =",
          style: const TextStyle(
            color: AppStyle.kGrayFontColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        IntrinsicWidth(
          child: Column(
            children: [
              FittedBox(
                child: Text(
                  "${CurrencyFormatter.format((rateValue * 100).toString())} $codeOut",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 48,
                  ),
                ),
              ),
              const Divider(),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "1 $codeIn = ",
                style: const TextStyle(
                  color: AppStyle.kGrayFontColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Qanelas',
                ),
              ),
              TextSpan(
                text: "${CurrencyFormatter.format((rate * 100).toString())} $codeOut",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Qanelas',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
