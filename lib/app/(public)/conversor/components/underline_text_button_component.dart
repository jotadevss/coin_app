import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../shared/theme.dart';

class UnderlineTextButton extends StatefulWidget {
  const UnderlineTextButton({super.key, required this.title, required this.onPressed});

  final String title;
  final void Function() onPressed;

  @override
  State<UnderlineTextButton> createState() => _UnderlineTextButtonState();
}

class _UnderlineTextButtonState extends State<UnderlineTextButton> {
  bool pressedClearAll = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => pressedClearAll = true);
        widget.onPressed.call();
      },
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: IntrinsicWidth(
          child: Column(
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  height: 0.8,
                  color: AppStyle.kPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ).animate(target: pressedClearAll ? 1 : 0).tint(color: const Color(0xFF094691), curve: Curves.linear).listen(
                  delay: const Duration(milliseconds: 300),
                  callback: (_) => setState(() {
                        pressedClearAll = false;
                      })),
              const Divider(color: AppStyle.kPrimaryColor)
                  .animate(target: pressedClearAll ? 1 : 0)
                  .tint(color: const Color(0xFF094691), curve: Curves.linear)
                  .listen(
                      delay: const Duration(milliseconds: 300),
                      callback: (_) => setState(() {
                            pressedClearAll = false;
                          })),
            ],
          ),
        ),
      ),
    );
  }
}
