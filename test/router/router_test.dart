import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tools/flutter_tools.dart';
import 'package:flutter_tools/src/router/custom_transition_builder.dart';

void main() {
  final route = Router();
  test('Should add route', () {
    route.addRoute('name', (context) =>  Container());
    expect(route.routes['name'](null), isA<Container>());
  });
  test(
      'Should create a theme with cupertino for ios, mac and custom for others',
      () {
    final theme = route.transitionsTheme;
    for (final key in theme.builders.keys) {
      if (key == TargetPlatform.iOS || key == TargetPlatform.macOS) {
        expect(theme.builders[key], const CupertinoPageTransitionsBuilder());
      } else {
        expect(theme.builders[key], const CustomTransitionBuilder());
      }
    }
  });
}
