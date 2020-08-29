part of 'router_impl.dart';

abstract class Router {
  factory Router() = _RouterImpl;

  void addRoute(String name, WidgetBuilder builder);

  Map<String, WidgetBuilder> get routes;

  PageTransitionsTheme get transitionsTheme;
}
