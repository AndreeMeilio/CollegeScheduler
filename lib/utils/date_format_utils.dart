
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';

class DateFormatUtils {
  static String dateFormatyMMdd({
    required DateTime date
  }) {
    final formatter = DateFormat('y-MM-dd');
    final result = formatter.format(date);
    
    return result;
  }

  static String dateFormatyMMddkkiiss({
    required DateTime date
  }) {
    final formatter = DateFormat('y-MM-dd kk:mm:ss');
    final result = formatter.format(date);

    return result;
  }

  static String dateFormatddMMMMy({
    required DateTime date
  }) {
    final formatter = DateFormat('dd MMMM y');
    final result = formatter.format(date);

    return result;
  }

  static String dateFormatddMMMMykkiiss({
    required DateTime date
  }) {
    final formatter = DateFormat('dd MMMM y kk:mm:ss');
    final result = formatter.format(date);

    return result;
  }

  static String dateFormatjms({
    required DateTime date
  }) {
    final formatter = DateFormat('jms');
    final result = formatter.format(date);

    return result;
  }

  static Location getLocationTimeZone(){
      return getLocation("Asia/Jakarta");
  }
}