import 'package:coin_app/app/shared/theme.dart';
import 'package:coin_app/app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectCurrency extends StatelessWidget {
  const SelectCurrency({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.label,
    required this.onClear,
    required this.iconPath,
  });

  final String label;
  final String title;
  final String subtitle;
  final String iconPath;
  final void Function() onTap;
  final void Function()? onClear;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.15),
            borderRadius: BorderRadius.circular(99),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(99),
              splashColor: AppStyle.kPrimaryColor.withOpacity(0.05),
              overlayColor: MaterialStatePropertyAll(AppStyle.kPrimaryColor.withOpacity(0.05)),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppStyle.kPrimaryColor.withOpacity(0.1),
                      child: SvgPicture.asset("lib/assets/icons/arrow-in.svg", width: 22),
                    ),
                    const SizedBox(width: 16),
                    LimitedBox(
                      maxWidth: SizeConfig.blockSizeHorizontal! * 45,
                      child: FittedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              subtitle,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                  ],
                ),
              ),
            ),
            if (SizeConfig.screenWidth! > 295 && onClear != null)
              LimitedBox(
                maxWidth: SizeConfig.blockSizeHorizontal! * 10,
                child: FittedBox(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.close,
                      color: AppStyle.kPrimaryColor,
                      size: 20,
                    ),
                    splashColor: AppStyle.kPrimaryColor.withOpacity(0.05),
                    style: ButtonStyle(
                      overlayColor: MaterialStatePropertyAll(AppStyle.kPrimaryColor.withOpacity(0.05)),
                    ),
                  ),
                ),
              ),
          ],
        ),
        if (SizeConfig.screenWidth! < 295 && onClear != null)
          TextButton(
            onPressed: onClear,
            style: ButtonStyle(
              overlayColor: MaterialStatePropertyAll(AppStyle.kPrimaryColor.withOpacity(0.1)),
            ),
            child: const Text(
              "Limpar",
              style: TextStyle(
                color: AppStyle.kPrimaryColor,
                fontSize: 16,
                decoration: TextDecoration.underline,
                decorationColor: AppStyle.kPrimaryColor,
              ),
            ),
          ),
      ],
    );
  }
}
