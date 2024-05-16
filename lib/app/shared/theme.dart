import 'package:flutter/material.dart';

class AppStyle {
  // App Colors
  static const Color kPrimaryColor = Color(0xff2A77D3);
  static const Color kGrayFontColor = Color(0xff909090);
  static const Color kGreenPrimaryColor = Color(0xff0EAE61);

  // App Icons ("s" prefix to SVG icon path)
  static const String sCodeOutIcon = "lib/assets/icons/arrow-out.svg";
  static const String sCodeInIcon = "lib/assets/icons/arrow-in.svg";
  static const String sArrowTrendDownIcon = "lib/assets/icons/arrow-trend-down.svg";
  static const String sArrowTrendUpIcon = "lib/assets/icons/arrow-trend-up.svg";
  static const String sCloseCircleIcon = "lib/assets/icons/close-circle.svg";
  static const String sDiagramIcon = "lib/assets/icons/diagram.svg";
  static const String sFlipArrowIcon = "lib/assets/icons/flip-arrow.svg";
  static const String sMoneyLogoIcon = "lib/assets/icons/moneys.svg";
  static const String sSearchIcon = "lib/assets/icons/search.svg";
  static const String sTrendDownIcon = "lib/assets/icons/trend-down.svg";
  static const String sTrendUpIcon = "lib/assets/icons/trend-up.svg";

  // Icons for currencies
  static String getCurrencyFlag(String code) => "lib/assets/flags/${code.toLowerCase()}.svg";
}
