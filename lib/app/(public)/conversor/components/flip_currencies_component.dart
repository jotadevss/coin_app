import 'package:coin_app/app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FlipCurrencies extends StatelessWidget {
  const FlipCurrencies({
    super.key,
    required this.onPressed,
    required this.enable,
  });

  final void Function() onPressed;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: enable ? onPressed : null,
      style: ButtonStyle(
        backgroundColor: enable ? null : MaterialStatePropertyAll(AppStyle.kGrayFontColor.withOpacity(0.1)),
        fixedSize: const MaterialStatePropertyAll(Size(180, 40)),
        side: MaterialStatePropertyAll(enable ? const BorderSide(color: AppStyle.kPrimaryColor) : BorderSide.none),
        overlayColor: MaterialStatePropertyAll(enable ? AppStyle.kPrimaryColor.withOpacity(0.1) : Colors.transparent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "lib/assets/icons/flip-arrow.svg",
            colorFilter: enable ? null : const ColorFilter.mode(AppStyle.kGrayFontColor, BlendMode.srcIn),
            width: 15,
          ),
          const SizedBox(width: 8),
          Text(
            "Trocar moedas",
            style: TextStyle(
              color: enable ? AppStyle.kPrimaryColor : AppStyle.kGrayFontColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
