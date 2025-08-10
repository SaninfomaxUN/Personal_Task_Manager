import 'dart:convert';
import '../../config/config.dart';

Future<bool> checkExpirationTime() async {
  final String accessToken = await Config.getAccessToken() ?? '';
  final parts = accessToken.split('.');
  if (parts.length != 3) {
    return false;
  }
  final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
  DateTime expirationDateTime = DateTime.fromMillisecondsSinceEpoch(json.decode(payload)['exp'] * 1000, isUtc: true);
  DateTime currentDateTimeUtc = DateTime.now().toUtc();
  return !currentDateTimeUtc.isAfter(expirationDateTime);

}