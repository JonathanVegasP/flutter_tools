abstract class Injector {
  void putSingleton<T>(T factory());

  void putLazy<T>(T factory());

  void putFactory<T>(T factory());

  bool isRegistered<T>();

  T call<T>();

  void unRegister<T>();

  void clear();
}
