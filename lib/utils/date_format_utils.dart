
import 'package:intl/intl.dart';

class DateFormatUtils {
  static String dateFormatyMMdd({
    required DateTime date
  }) {
    final formatter = DateFormat('y-MM-dd');
    final result = formatter.format(date);
    
    return result;
  }

  static String dateFormatyMMddhhiiss({
    required DateTime date
  }) {
    final formatter = DateFormat('y-MM-dd hh:mm:ss');
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

  static String dateFormatddMMMMyhhiiss({
    required DateTime date
  }) {
    final formatter = DateFormat('dd MMMM y hh:mm:ss');
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
}