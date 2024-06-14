import 'package:coin_app/app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class VariationAppBar extends StatelessWidget {
  const VariationAppBar({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () {
            Routefly.pop(context);
          },
          style: ButtonStyle(
            shape: const MaterialStatePropertyAll(
              CircleBorder(),
            ),
            side: MaterialStatePropertyAll(
              BorderSide(color: Colors.grey.withOpacity(0.1)),
            ),
            padding: const MaterialStatePropertyAll(EdgeInsets.all(18)),
            overlayColor: MaterialStatePropertyAll(AppStyle.kPrimaryColor.withOpacity(0.05)),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 16,
          ),
        ),
        const SizedBox(height: 0, width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.replaceAll("-", "/"),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppStyle.kGrayFontColor.withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
