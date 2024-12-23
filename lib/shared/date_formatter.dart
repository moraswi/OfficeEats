import 'package:intl/intl.dart';

class DateFormatter {
  // Function to format the date
  static String formatDate(String date) {
    try {
      final DateTime parsedDate = DateTime.parse(date);
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    } catch (e) {
      // Return an error message or handle invalid date strings
      return 'Invalid Date';
    }
  }
}
