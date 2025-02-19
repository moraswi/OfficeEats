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

  static String formatDateTime(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    return DateFormat('yyyy-MM-dd HH:mm').format(parsedDate); // Example: 2024-08-27 14:30
  }

  static String formatTime(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    return DateFormat('HH:mm').format(parsedDate); // Example: 2024-08-27 14:30
  }
}
