import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tools/flutter_tools.dart';

void main() {
  final injection = Injection();
  test('Injection should not have two instances', () {
    final value = Injection();
    expect(injection == value, isTrue);
  });
  test('Injection should reject dynamic type', () {
    expect(() {
      injection.putFactory<dynamic>(() => null);
    }, throwsAssertionError);
    expect(() {
      injection.putLazy<dynamic>(() => null);
    }, throwsAssertionError);
    expect(() {
      injection.putSingleton<dynamic>(() => null);
    }, throwsAssertionError);
  });
  test('Test register factory', () {
    injection.putFactory(() => Object());
    expect(injection.isRegistered<Object>(), isTrue);
    expect(() {
      injection.putFactory(() => Object());
    }, throwsAssertionError);
    final Object value1 = injection();
    final Object value2 = injection();
    expect(value1 == value2, isFalse);
    injection.unRegister<Object>();
    expect(injection.isRegistered<Object>(), isFalse);
    injection.putFactory(() => null);
    expect(() {
      injection<Null>();
    }, throwsAssertionError);
    injection.unRegister<Null>();
    expect(injection.isRegistered<Null>(), isFalse);
  });
  test('Test register lazy', () {
    injection.putLazy(() => Object());
    expect(injection.isRegistered<Object>(), isTrue);
    expect(() {
      injection.putLazy(() => Object());
    }, throwsAssertionError);
    final Object value1 = injection();
    final Object value2 = injection();
    expect(value1 == value2, isTrue);
    injection.unRegister<Object>();
    expect(injection.isRegistered<Object>(), isFalse);
    injection.putLazy(() => null);
    expect(() {
      injection<Null>();
    }, throwsAssertionError);
    injection.unRegister<Null>();
    expect(injection.isRegistered<Null>(), isFalse);
  });
  test('Test register singleton', () {
    injection.putSingleton(() => Object());
    expect(injection.isRegistered<Object>(), isTrue);
    expect(() {
      injection.putSingleton(() => Object());
    }, throwsAssertionError);
    final Object value1 = injection();
    final Object value2 = injection();
    expect(value1 == value2, isTrue);
    injection.unRegister<Object>();
    expect(injection.isRegistered<Object>(), isFalse);
    expect(() {
      injection.putSingleton(() => null);
    }, throwsAssertionError);
    expect(injection.isRegistered<Null>(), isFalse);
  });
  test('Injection should reset register objects on calling reset', () {
    injection.putLazy(() => 0);
    injection.putSingleton(() => '');
    injection.putFactory(() => []);
    expect(injection.isRegistered<int>(), isTrue);
    expect(injection.isRegistered<String>(), isTrue);
    expect(injection.isRegistered<List>(), isTrue);
    injection.reset();
    expect(injection.isRegistered<int>(), isFalse);
    expect(injection.isRegistered<String>(), isFalse);
    expect(injection.isRegistered<List>(), isFalse);
  });
}
