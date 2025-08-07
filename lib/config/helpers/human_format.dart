import 'package:intl/intl.dart';

class HumanFormat {
  static String number(double number, {int decimalDigits = 0}) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits,
      symbol: '',
    ).format(number);

    return formattedNumber;
  }
}
