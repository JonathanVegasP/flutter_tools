import 'package:flutter/material.dart';

class ObserverValue<T> extends StatefulWidget {
  final T initial;
  final Widget child;

  const ObserverValue({Key key, this.initial, @required this.child})
      : assert(child != null, '''
            A null child was provided inside this $ObserverValue widget
            '''),
        super(key: key);

  static ObserverValueState<T> of<T>(BuildContext context, [update = true]) {
    if (update) {
      return context
          .dependOnInheritedWidgetOfExactType<_ObserverValue<T>>()
          .state;
    }
    final _ObserverValue<T> value = context
        .getElementForInheritedWidgetOfExactType<_ObserverValue<T>>()
        .widget;
    return value.state;
  }

  @override
  ObserverValueState<T> createState() => ObserverValueState<T>();
}

class ObserverValueState<T> extends State<ObserverValue<T>> {
  T _value;

  @override
  void initState() {
    _value = widget.initial;
    super.initState();
  }

  T get value => _value;

  set value(T value) {
    setState(() {
      _value = value;
    });
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '$_value';
  }

  @override
  Widget build(BuildContext context) {
    return _ObserverValue<T>(
      child: widget.child,
      state: this,
      value: _value,
    );
  }
}

class _ObserverValue<T> extends InheritedWidget {
  const _ObserverValue({
    Key key,
    @required this.state,
    @required this.value,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final ObserverValueState<T> state;

  final T value;

  @override
  bool updateShouldNotify(_ObserverValue<T> old) {
    return old.value != value;
  }
}

extension ObserverValueContext on BuildContext {
  ObserverValueState<T> read<T>() => ObserverValue.of<T>(this, false);

  ObserverValueState<T> watch<T>() => ObserverValue.of<T>(this, true);
}
