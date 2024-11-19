import 'package:intl/intl.dart';

class Formatters {
  static String formatCurrency(double amount) {
    final NumberFormat currencyFormatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    return currencyFormatter.format(amount);
  }

  static String formatNumber(int number) {
    final NumberFormat numberFormatter = NumberFormat('#,###');
    return numberFormatter.format(number);
  }
}
