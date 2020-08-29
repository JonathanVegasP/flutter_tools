import 'dart:async';

import 'dart:collection';

part 'observable.dart';

class _ObservableImpl<T> implements Observable<T> {
  final StreamController<T> _controller = StreamController.broadcast();
  final Map<Stream<T>, StreamSubscription<T>> _subscriptions = HashMap();
  T _value;

  _ObservableImpl([this._value]);

  @override
  T get value {
    if (getObservable != null) {
      getObservable.addListener(stream);
    }
    return _value;
  }

  @override
  set value(T value) {
    if (_value == value) {
      return;
    }
    _value = value;
    _controller.add(value);
  }

  @override
  void addListener(Stream<T> stream) {
    if (_subscriptions.containsKey(stream)) {
      return;
    }
    _subscriptions[stream] = stream.listen((event) {
      _controller.add(event);
    });
  }

  @override
  bool canUpdate() => _subscriptions.length > 0;

  @override
  Future<void> close() {
    _subscriptions.forEach((key, value) {
      value?.cancel();
    });
    _subscriptions.clear();
    return _controller.close();
  }

  @override
  StreamSubscription listen(void Function(T event) onData) =>
      stream.listen(onData);

  @override
  Stream<T> get stream => _controller.stream;

  @override
  String toString() => '$value';
}

Observable getObservable;

extension ObservableT<T> on T {
  Observable<T> get obs => Observable(this);
}
