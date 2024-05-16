import 'package:routefly/routefly.dart';

import 'app/(public)/conversor/conversor_page.dart' as a0;

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
];

const routePaths = (
  path: '/',
  conversor: '/conversor',
);
