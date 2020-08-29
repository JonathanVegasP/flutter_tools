import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tools/flutter_tools.dart';

void main() {
  test('Test if type is considering on runtime', () {
    final listDynamic = [].obs;
    Type getType<T>() => T;
    expect(
        listDynamic.value.runtimeType.toString() ==
            getType<List<dynamic>>().toString(),
        isTrue);
    final listInt = <int>[].obs;
    expect(
        listInt.value.runtimeType.toString() == getType<List<int>>().toString(),
        isTrue);
  });
  test('Test if is listening value on change', () {
    final counter = 0.obs;
    expect(counter.stream, emits(1));
    counter.value = 1;
  });
  test('Test if not listening if is the same value', () {
    final counter = 0.obs;
    expect(counter.stream, emits(1));
    counter.value = 0;
    counter.value = 1;
  });
  test('Test if listeners is working', () {
    final counter = 0.obs;
    final counter2 = 0.obs;
    expect(counter2.stream, emits(1));
    expect(counter2.canUpdate(), isFalse);
    getObservable = counter2;
    counter.value;
    getObservable = null;
    expect(counter2.canUpdate(), isTrue);
    counter.value++;
    expect(counter.value == 1, isTrue);
  });
  test('Test if is closing stream', () async {
    final counter = 0.obs;
    await counter.close();
    expect(() {
      counter.value = 1;
    }, throwsStateError);
  });
}
