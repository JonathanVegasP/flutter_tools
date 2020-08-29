import 'package:flutter/material.dart';
import 'package:flutter_tools/src/observable/observable_impl.dart';

class Observer extends StatefulWidget {
  final WidgetBuilder builder;

  const Observer(this.builder, {Key key}) : super(key: key);

  @override
  _ObserverState createState() => _ObserverState();
}

class _ObserverState extends State<Observer> {
  Observable observable = Observable();

  @override
  void initState() {
    observable.listen((_) {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    observable.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getObservable = observable;
    final child = widget.builder(context);
    assert(child != null, '''
    Observable: a null widget was provided inside ${widget.builder} function
    ''');
    getObservable = null;
    assert(observable.canUpdate(), '''
    Observable: an Observable was not detected inside this $widget widget
    ''');
    return child;
  }
}
