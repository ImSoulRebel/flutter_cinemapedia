import 'package:intl/intl.dart';

class HumanFormat {
  static String number(double number, {int decimalDigits = 0}) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits,
      symbol: '',
    ).format(number);

    return formattedNumber;
  }

  static String shortDate(DateTime? date) {
    if (date == null) return '';

    final format = DateFormat.yMMMEd('es');
    return format.format(date);
  }
}
