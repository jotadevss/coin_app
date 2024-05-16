import 'package:coin_app/app/shared/theme.dart';
import 'package:coin_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: Routefly.routerConfig(routes: routes, initialPath: routePaths.conversor),
      theme: ThemeData(
        fontFamily: 'Qanelas',
        primaryColor: AppStyle.kPrimaryColor,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppStyle.kPrimaryColor,
          selectionColor: AppStyle.kPrimaryColor,
          selectionHandleColor: AppStyle.kPrimaryColor,
        ),
      ),
    );
  }
}
