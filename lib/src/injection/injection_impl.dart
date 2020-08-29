import 'dart:collection';

import 'service.dart';

part 'injection.dart';

class _InjectionImpl implements Injection {
  final Map<Type, Service> _services = HashMap();

  static Injection _instance;

  _InjectionImpl._();

  factory _InjectionImpl() => _instance ??= _InjectionImpl._();

  @override
  T call<T>() => find<T>();

  void _validateRegister<T>() {
    assert(isRegistered<T>(), '''
    Injection: $T is not registered
    ''');
  }

  @override
  T find<T>() {
    _validateRegister<T>();
    final Service<T> service = _services[T];
    return service?.read();
  }

  @override
  bool isRegistered<T>() => _services.containsKey(T);

  void _validate<T>() {
    assert(!isRegistered<T>(), '''
    Injection: $T is already registered
    ''');
    assert(T != dynamic, '''
    Injection: can't register or read an object with a dynamic type
    ''');
  }

  @override
  void putFactory<T>(T create()) {
    _validate<T>();
    final service = Service<T>(
      create: create,
      type: ServiceType.factory,
    );
    _services[T] = service;
  }

  @override
  void putLazy<T>(T create()) {
    _validate<T>();
    final service = Service<T>(
      create: create,
      type: ServiceType.lazy,
    );
    _services[T] = service;
  }

  @override
  void putSingleton<T>(T create()) {
    _validate<T>();
    T obj;
    try {
      obj = create();
      assert(obj != null, '''
      $T can't be registered with a null value
      ''');
    } catch (e, str) {
      print('Error while creating $T is: $e');
      print(str);
      rethrow;
    }
    final service = Service<T>(instance: obj, type: ServiceType.singleton);
    _services[T] = service;
  }

  @override
  void reset() {
    _services.clear();
  }

  @override
  void unRegister<T>() {
    _validateRegister<T>();
    _services.remove(T);
  }
}
