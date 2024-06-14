import 'package:routefly/routefly.dart';

import 'app/(public)/conversor/conversor_page.dart' as a0;
import 'app/(public)/variation/variation_page.dart' as a1;

List<RouteEntity> get routes => [
  RouteEntity(
    key: '/conversor',
    uri: Uri.parse('/conversor'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a0.ConversorPage(),
    ),
  ),
  RouteEntity(
    key: '/variation',
    uri: Uri.parse('/variation'),
    routeBuilder: (ctx, settings) => Routefly.defaultRouteBuilder(
      ctx,
      settings,
      const a1.VariationPage(),
    ),
  ),
];

const routePaths = (
  path: '/',
  conversor: '/conversor',
  variation: '/variation',
);
