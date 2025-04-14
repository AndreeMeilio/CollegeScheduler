
import 'dart:math';

class RandomStringUtils {

  static String generateString({
    required int length
  }) {
    const _chars = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890";
    Random _rand = Random();
    final result = String.fromCharCodes(
      Iterable.generate(
        length,
        (index) => _chars.codeUnitAt(_rand.nextInt(_chars.length)),
      )
    );

    return result;
  }

}