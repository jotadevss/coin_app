import 'package:coin_app/app/shared/theme.dart';
import 'package:flutter/material.dart';

class QuotationValue extends StatelessWidget {
  const QuotationValue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "BRL 5.00 =",
          style: TextStyle(
            color: AppStyle.kGrayFontColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const IntrinsicWidth(
          child: Column(
            children: [
              FittedBox(
                child: Text(
                  "0,961 USD",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 48,
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "1 USD = ",
                style: TextStyle(
                  color: AppStyle.kGrayFontColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Qanelas',
                ),
              ),
              TextSpan(
                text: "5,20 BRL",
                style: TextStyle(
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
