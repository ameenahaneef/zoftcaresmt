import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage _storage=FlutterSecureStorage();

const String accessTokenKey='accessToken';
const String expiryTimeKey='validity';

Future<void>storeTokens(String accessToken ,int valididty)async{
  await _storage.write(key: accessTokenKey, value: accessToken);
  final expiryDate=DateTime.now().add(Duration(milliseconds:valididty ));
  await _storage.write(key: expiryTimeKey, value:expiryDate.toIso8601String());
}

Future<String?> getAccessToken() async {
  return await _storage.read(key: accessTokenKey);
}

Future<DateTime?> getTokenExpiryTime() async {
  final expiryDateStr = await _storage.read(key: expiryTimeKey);
  if (expiryDateStr != null) {
    return DateTime.parse(expiryDateStr);
  }
  return null;
}