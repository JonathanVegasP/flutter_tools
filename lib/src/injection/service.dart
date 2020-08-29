enum ServiceType { singleton, lazy, factory }

class Service<T> {
  T instance;
  final T Function() create;
  final ServiceType type;

  Service({this.instance, this.create, this.type});

  void _validate([T value]) {
    assert(value != null || instance != null, '''
    $T was registered with a null value
    ''');
  }

  T read() {
    try {
      switch (type) {
        case ServiceType.singleton:
          return instance;
        case ServiceType.lazy:
          if (instance == null) {
            instance = create();
            _validate();
          }
          return instance;
        case ServiceType.factory:
          final obj = create();
          _validate(obj);
          return obj;
        default:
          throw StateError('Invalid Injection type');
      }
    } catch (e, str) {
      print('Error while creating $T is: $e');
      print(str);
      rethrow;
    }
  }
}
