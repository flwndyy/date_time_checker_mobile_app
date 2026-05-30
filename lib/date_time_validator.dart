class ValidationResult {
  final bool isValid;
  final String message;
  final String details;

  ValidationResult({
    required this.isValid,
    required this.message,
    required this.details,
  });
}

class DateTimeValidator {
  /// Validates a date given day, month (or "time"), and year inputs.
  static ValidationResult validate(
    String dayInput,
    String monthOrTimeInput,
    String yearInput,
  ) {
    // 1. Check for empty inputs
    if (dayInput.trim().isEmpty) {
      return ValidationResult(
        isValid: false,
        message: "Day cannot be empty.",
        details: "Please enter a valid day of the month.",
      );
    }
    if (monthOrTimeInput.trim().isEmpty) {
      return ValidationResult(
        isValid: false,
        message: "Month cannot be empty.",
        details: "Please enter a valid month (1-12).",
      );
    }
    if (yearInput.trim().isEmpty) {
      return ValidationResult(
        isValid: false,
        message: "Year cannot be empty.",
        details: "Please enter a valid year.",
      );
    }

    final dayStr = dayInput.trim();
    final monthOrTimeStr = monthOrTimeInput.trim();
    final yearStr = yearInput.trim();

    // 2. Parse Year
    final year = int.tryParse(yearStr);
    if (year == null) {
      return ValidationResult(
        isValid: false,
        message: "Invalid Year format.",
        details: "Year must be a valid integer number.",
      );
    }
    if (year < 1 || year > 9999) {
      return ValidationResult(
        isValid: false,
        message: "Year out of range.",
        details: "Year must be between 1 and 9999.",
      );
    }

    // 3. Parse Month
    int? month = int.tryParse(monthOrTimeStr);
    if (month == null) {
      // Try parsing English month names or abbreviations
      final mLower = monthOrTimeStr.toLowerCase();
      if (mLower == "jan" || mLower == "january") {
        month = 1;
      } else if (mLower == "feb" || mLower == "february") {
        month = 2;
      } else if (mLower == "mar" || mLower == "march") {
        month = 3;
      } else if (mLower == "apr" || mLower == "april") {
        month = 4;
      } else if (mLower == "may") {
        month = 5;
      } else if (mLower == "jun" || mLower == "june") {
        month = 6;
      } else if (mLower == "jul" || mLower == "july") {
        month = 7;
      } else if (mLower == "aug" || mLower == "august") {
        month = 8;
      } else if (mLower == "sep" || mLower == "september") {
        month = 9;
      } else if (mLower == "oct" || mLower == "october") {
        month = 10;
      } else if (mLower == "nov" || mLower == "november") {
        month = 11;
      } else if (mLower == "dec" || mLower == "december") {
        month = 12;
      } else {
        // Detect time format entry typo
        if (monthOrTimeStr.contains(":")) {
          return ValidationResult(
            isValid: false,
            message: "Month box contains a Time string.",
            details: "It looks like you typed a time (e.g. $monthOrTimeStr) in the Month box! In standard date checkers, this field expects the Month (1-12). Please input a number from 1 to 12.",
          );
        }
        return ValidationResult(
          isValid: false,
          message: "Invalid Month format.",
          details: "Month must be a valid integer (1-12) or standard month name.",
        );
      }
    }

    if (month < 1 || month > 12) {
      return ValidationResult(
        isValid: false,
        message: "Month out of range.",
        details: "Month must be an integer between 1 and 12.",
      );
    }

    // 4. Parse Day
    final day = int.tryParse(dayStr);
    if (day == null) {
      return ValidationResult(
        isValid: false,
        message: "Invalid Day format.",
        details: "Day must be a valid integer number.",
      );
    }
    if (day < 1 || day > 31) {
      return ValidationResult(
        isValid: false,
        message: "Day out of range.",
        details: "Day must be between 1 and 31.",
      );
    }

    // 5. Calendar constraints check
    final isLeap = isLeapYear(year);
    final maxDays = getDaysInMonth(month, year);

    if (day > maxDays) {
      final monthName = getMonthName(month);
      if (month == 2) {
        final leapExplanation = isLeap
            ? "Year $year is a Leap Year, so February has a maximum of 29 days."
            : "Year $year is NOT a Leap Year, so February has a maximum of 28 days.";
        return ValidationResult(
          isValid: false,
          message: "Invalid date for $monthName.",
          details: "$leapExplanation You entered $day.",
        );
      } else {
        return ValidationResult(
          isValid: false,
          message: "Invalid date for $monthName.",
          details: "$monthName has a maximum of $maxDays days. You entered $day.",
        );
      }
    }

    // 6. Success!
    final formattedDate =
        "${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/${year.toString().padLeft(4, '0')}";
    final dateTime = DateTime(year, month, day);
    final weekDays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ];
    final dayOfWeek = weekDays[dateTime.weekday - 1];

    var successDetails =
        "The date $formattedDate is a valid calendar date.\nIt falls on a $dayOfWeek.";
    if (isLeap) {
      successDetails += "\n(Year $year is a Leap Year!)";
    }

    return ValidationResult(
      isValid: true,
      message: "Valid Date!",
      details: successDetails,
    );
  }

  static bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  static int getDaysInMonth(int month, int year) {
    if (month == 2) {
      return isLeapYear(year) ? 29 : 28;
    }
    if (month == 4 || month == 6 || month == 9 || month == 11) {
      return 30;
    }
    return 31;
  }

  static String getMonthName(int month) {
    const names = [
      "",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return names[month];
  }
}
