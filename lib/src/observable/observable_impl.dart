import 'dart:collection';

import '../validators/validators.dart';

part 'observable.dart';

class _Observable<T> implements Observable<T> {
  Map<Observable<T>, _Listener<T>> observers;
  final Map<_Listener<T>, Null> listeners = HashMap();
  T _value;

  _Observable([this._value]);

  @override
  T get value {
    if (getObs.isNotNull) {
      getObs.addListener(this);
    }
    return _value;
  }

  @override
  set value(T value) {
    if (_value == value) return;
    _value = value;
    listeners.forEach((key, value) {
      key(_value);
    });
  }

  @override
  void addListener(Observable<T> observable) {
    if (observers.isNull)
      observers = HashMap();
    else if (observers.containsKey(observable)) return;
    final _Listener<T> callback = (event) {
      value = event;
    };
    observable.listen(callback);
    observers[observable] = callback;
  }

  @override
  bool canUpdate() => observers.isNotNull;

  @override
  void dispose() {
    listeners.clear();
    observers?.forEach((key, value) {
      key.unListen(value);
    });
    observers?.clear();
    observers = null;
  }

  @override
  void listen(void Function(T event) onData) => listeners[onData] = null;

  @override
  void unListen(void Function(T event) onData) => listeners.remove(onData);

  @override
  String toString() => '$value';
}

typedef _Listener<T> = void Function(T event);

Observable getObs;

extension ObservableX<T> on T {
  Observable<T> get obs => Observable(this);
}
