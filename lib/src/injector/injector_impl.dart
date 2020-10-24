import 'dart:collection';

import '../validators/validators.dart';
import 'injector.dart';

enum _ServiceType { singleton, lazy, factory }

void _runOrCatch(void action(), Type T) {
  try {
    action();
  } catch (e, str) {
    print('Injector: Error while creating $T instance');
    print(str);
    rethrow;
  }
}

void _validate(instance, Type T) {
  if (instance.isNull) {
    throw ArgumentError('Injector: $T was registered as $Null');
  }
}

class _ServiceFactory<T> {
  T instance;
  final T Function() factory;
  final _ServiceType type;

  _ServiceFactory({this.instance, this.factory, this.type});

  T call() {
    switch (type) {
      case _ServiceType.singleton:
        return instance;
      case _ServiceType.lazy:
        if (instance.isNull) {
          _runOrCatch(() => instance = factory(), T);
          _validate(instance, T);
        }
        return instance;
      case _ServiceType.factory:
        T instance;
        _runOrCatch(() => instance = factory(), T);
        _validate(instance, T);
        return instance;
      default:
        throw StateError('Impossible case');
    }
  }
}

class _Injector implements Injector {
  final Map<Type, _ServiceFactory<dynamic>> _services = HashMap();

  _Injector._();

  void _isRegistered(Type T) {
    if (!_services.containsKey(T)) {
      throw ArgumentError("Injector: $T is not registered");
    }
  }

  void _isNotRegistered(Type T) {
    if (_services.containsKey(T)) {
      throw ArgumentError("Injector: $T is already registered");
    }
  }

  @override
  T call<T>() {
    _isRegistered(T);
    final _ServiceFactory<T> factory = _services[T];
    return factory();
  }

  @override
  void clear() => _services.clear();

  @override
  bool isRegistered<T>() => _services.containsKey(T);

  @override
  void putFactory<T>(T Function() factory) {
    _isNotRegistered(T);
    _services[T] = _ServiceFactory<T>(
      factory: factory,
      type: _ServiceType.factory,
    );
  }

  @override
  void putLazy<T>(T Function() factory) {
    _isNotRegistered(T);
    _services[T] = _ServiceFactory<T>(
      factory: factory,
      type: _ServiceType.lazy,
    );
  }

  @override
  void putSingleton<T>(T Function() factory) {
    _isNotRegistered(T);
    T instance;
    _runOrCatch(() => instance = factory(), T);
    _validate(instance, T);
    _services[T] = _ServiceFactory<T>(
      instance: instance,
      type: _ServiceType.singleton,
    );
  }

  @override
  void unRegister<T>() => _services.remove(T);
}

final Injector serviceInjector = _Injector._();
