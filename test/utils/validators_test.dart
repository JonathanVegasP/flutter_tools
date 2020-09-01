import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tools/flutter_tools.dart';

void main() {
  test('Test if all validations is working', () {
    var object = '    ';
    expect(AppValidators.isNullOrEmpty(object), isTrue);
    expect(AppValidators.isNotNullOrEmpty(object), isFalse);
    expect(AppValidators.isNull(object), isFalse);
    expect(AppValidators.isNotNull(object), isTrue);
    object = 'a';
    expect(AppValidators.isNullOrEmpty(object), isFalse);
    expect(AppValidators.isNotNullOrEmpty(object), isTrue);
    expect(AppValidators.isNull(object), isFalse);
    expect(AppValidators.isNotNull(object), isTrue);
    object = null;
    expect(AppValidators.isNull(object), isTrue);
    expect(AppValidators.isNotNull(object), isFalse);
    object = 'example@example.com';
    expect(AppValidators.isEmail(object), isTrue);
    object = 'example';
    expect(AppValidators.isEmail(object), isFalse);
    object = 'example.@example.com';
    expect(AppValidators.isEmail(object), isFalse);
    object = 'example@e.com';
    expect(AppValidators.isEmail(object), isFalse);
    object = 'example@.com';
    expect(AppValidators.isEmail(object), isFalse);
    object = 'example@example.c';
    expect(AppValidators.isEmail(object), isFalse);
    object = 'example@example';
    expect(AppValidators.isEmail(object), isFalse);
    object = 'John Doe';
    expect(AppValidators.isFullName(object), isTrue);
    object = 'John';
    expect(AppValidators.isFullName(object), isFalse);
    expect(AppValidators.fieldValidation(AppValidators.isFullName)(object),
        'Campo inválido');
    expect(
        AppValidators.fieldValidation(AppValidators.isFullName, 'teste')(
            object),
        'teste');
    object = 'John Doe';
    expect(
        AppValidators.fieldValidation(AppValidators.isFullName)(object), null);
    expect(
        AppValidators.fieldValidation(AppValidators.isFullName, 'teste')(
            object),
        null);
    object = '1234567890';
    expect(AppValidators.maxLength(object, 10), isTrue);
    expect(AppValidators.minLength(object, 11), isFalse);
    object = '123456';
    expect(AppValidators.maxLength(object, 5), isFalse);
    expect(AppValidators.minLength(object, 6), isTrue);
  });
}
