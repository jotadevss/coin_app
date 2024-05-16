import 'package:coin_app/app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FlipCurrencies extends StatelessWidget {
  const FlipCurrencies({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: const MaterialStatePropertyAll(Size(180, 40)),
        side: const MaterialStatePropertyAll(BorderSide(color: AppStyle.kPrimaryColor)),
        overlayColor: MaterialStatePropertyAll(AppStyle.kPrimaryColor.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "lib/assets/icons/flip-arrow.svg",
            width: 15,
          ),
          const SizedBox(width: 8),
          const Text(
            "Trocar moedas",
            style: TextStyle(
              color: AppStyle.kPrimaryColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
