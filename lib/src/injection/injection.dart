part of 'injection_impl.dart';

abstract class Injection {
  factory Injection() = _InjectionImpl;

  void putSingleton<T>(T create());

  void putLazy<T>(T create());

  void putFactory<T>(T create());

  T call<T>();

  T find<T>();

  bool isRegistered<T>();

  void unRegister<T>();

  void reset();
}
