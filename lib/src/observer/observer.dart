import 'package:flutter/material.dart';

import '../observable/observable_impl.dart';

class Observer extends StatefulWidget {
  final WidgetBuilder builder;

  const Observer(this.builder) : super();

  @override
  _ObserverState createState() => _ObserverState();
}

class _ObserverState extends State<Observer> {
  final observable = Observable();

  @override
  void initState() {
    observable.listen((event) {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    observable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getObs = observable;
    final child = widget.builder(context);
    getObs = null;
    assert(
      observable.canUpdate(),
      'Observable: Was not detected any Observable inside this Observer',
    );
    assert(child != null);
    return child;
  }
}
