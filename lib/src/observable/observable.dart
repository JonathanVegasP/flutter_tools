part of 'observable_impl.dart';

abstract class Observable<T> {
  factory Observable([T value]) = _Observable;

  T get value;

  set value(T value);

  void listen(void onData(T event));

  void unListen(void onData(T event));

  void dispose();
}
