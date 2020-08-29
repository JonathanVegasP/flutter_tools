import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_tools/src/router/custom_transition_builder.dart';

part 'router.dart';

class _RouterImpl implements Router {
  final Map<String, WidgetBuilder> _routes = HashMap();

  PageTransitionsTheme _theme;

  @override
  void addRoute(String name, builder) {
    _routes[name] = builder;
  }

  @override
  Map<String, WidgetBuilder> get routes => _routes;

  @override
  PageTransitionsTheme get transitionsTheme {
    if (_theme != null) {
      return _theme;
    }
    final map = <TargetPlatform, PageTransitionsBuilder>{};
    for (final value in TargetPlatform.values) {
      if (value == TargetPlatform.iOS || value == TargetPlatform.macOS) {
        map[value] = const CupertinoPageTransitionsBuilder();
        continue;
      }
      map[value] = const CustomTransitionBuilder();
    }
    _theme = PageTransitionsTheme(builders: map);
    return _theme;
  }
}
