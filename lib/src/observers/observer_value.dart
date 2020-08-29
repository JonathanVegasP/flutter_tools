import 'package:flutter/material.dart';

class ObserverValue<T> extends StatefulWidget {
  final T initial;
  final Widget child;

  const ObserverValue({Key key, this.initial, this.child}) : super(key: key);

  static ObserverValueState<T> of<T>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ObserverValue<T>>()
        .state;
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
  Widget build(BuildContext context) {
    return _ObserverValue<T>(
      child: widget.child,
      state: this,
      data: _value,
    );
  }
}

class _ObserverValue<T> extends InheritedWidget {
  const _ObserverValue({
    Key key,
    @required this.state,
    @required this.data,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  final ObserverValueState<T> state;

  final T data;

  @override
  bool updateShouldNotify(_ObserverValue<T> old) {
    return old.data != data;
  }
}
