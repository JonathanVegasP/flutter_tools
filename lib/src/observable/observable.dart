part of 'observable_impl.dart';

abstract class Observable<T> {
  factory Observable([T value]) = _ObservableImpl;

  T get value;

  set value(T value);

  Stream<T> get stream;

  StreamSubscription listen(void onData(T event));

  void addListener(Stream<T> stream);

  bool canUpdate();

  Future<void> close();
}
