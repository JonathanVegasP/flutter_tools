import 'dart:convert';

import 'package:flutter/foundation.dart';

_decode(String input) {
  return json.decode(input);
}

String _encode(dynamic input) {
  return json.encode(input);
}

Future decodeFromJson(String input) {
  return compute(_decode, input);
}

Future<String> encodeToJson(dynamic input) {
  return compute(_encode, input);
}
