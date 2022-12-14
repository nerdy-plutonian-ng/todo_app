import 'package:flutter/material.dart';

import '../routes/home.dart';

MaterialPageRoute generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const Home());
    default:
      return MaterialPageRoute(builder: (_) => const Home());
  }
}
