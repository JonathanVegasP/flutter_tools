import 'package:flutter/widgets.dart';

import '../observable/observable_impl.dart';

class Obs extends ObserverWidget {
  final WidgetBuilder builder;

  const Obs(this.builder) : super();

  @override
  Widget build(BuildContext context) => builder(context);
}
