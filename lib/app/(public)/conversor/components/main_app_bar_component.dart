import 'package:coin_app/app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: const Text(
        "Conversor",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 26,
        ),
      ),
      subtitle: RichText(
        textAlign: TextAlign.start,
        text: const TextSpan(
          children: [
            TextSpan(
              text: "Promovido por",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontFamily: 'Qanelas',
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: " J&P",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Qanelas',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset("lib/assets/icons/moneys.svg"),
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          backgroundColor: const MaterialStatePropertyAll(AppStyle.kPrimaryColor),
        ),
      ),
    );
  }
}
