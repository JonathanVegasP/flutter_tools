import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tools/flutter_tools.dart';

void main() {
  test('Should encode json', () async {
    final encoded = await encodeJson({"teste": "teste"});
    expect(encoded, '{"teste":"teste"}');
  });
  test('Should decode json', () async {
    final decoded = await decodeJson('{"teste":"teste"}');
    expect(decoded, isA<Map>());
    expect((decoded as Map).containsKey('teste'), isTrue);
    expect(decoded['teste'], 'teste');
  });
  test('Should throw exception with wrong format', () {
    expect(() async {
      return await decodeJson('');
    }, throwsException);
    expect(() async {
      await encodeJson(Object());
    }, throwsException);
  });
}
