import 'dart:math';
import 'dart:convert';

String getRandString(int len) {
  var random = Random.secure();
  var values = List<int>.generate(len, (index) => random.nextInt(255));
  return base64UrlEncode(values);
}