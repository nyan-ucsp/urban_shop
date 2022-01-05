import 'package:encrypt/encrypt.dart' as encrypt_service;

class EncryptionService {
  static final key = encrypt_service.Key.fromUtf8(
      'com.green_data.urban_shop_mobile'); //Key Need length 32
  static final iv = encrypt_service.IV.fromLength(16);
  static final encrypter = encrypt_service.Encrypter(
    encrypt_service.AES(key),
  );

  static String encrypt({required String text}) {
    return encrypter.encrypt(text, iv: iv).base64;
  }

  static String decrypt({required String text}) {
    return encrypter.decrypt(encrypt_service.Encrypted.fromBase64(text), iv: iv);
  }
}
