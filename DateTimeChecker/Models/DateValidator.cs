using System;

namespace DateTimeChecker.Models;

public static class DateValidator
{
    public static ValidationResult Validate(string dayInput, string monthInput, string yearInput)
    {
        // 1. Check for empty inputs
        if (string.IsNullOrWhiteSpace(dayInput))
            return new ValidationResult(false, "Day cannot be empty.", "Please enter a valid day of the month.");
        if (string.IsNullOrWhiteSpace(monthInput))
            return new ValidationResult(false, "Month cannot be empty.", "Please enter a valid month (1-12).");
        if (string.IsNullOrWhiteSpace(yearInput))
            return new ValidationResult(false, "Year cannot be empty.", "Please enter a valid year.");

        // 2. Parse inputs safely
        if (!int.TryParse(dayInput.Trim(), out int day))
            return new ValidationResult(false, "Invalid Day format.", "Day must be a valid integer number.");
        if (!int.TryParse(monthInput.Trim(), out int month))
            return new ValidationResult(false, "Invalid Month format.", "Month must be a valid integer number.");
        if (!int.TryParse(yearInput.Trim(), out int year))
            return new ValidationResult(false, "Invalid Year format.", "Year must be a valid integer number.");

        // 3. Year & Month range check
        if (year < 1 || year > 9999)
            return new ValidationResult(false, "Year out of range.", "Year must be between 1 and 9999.");
        if (month < 1 || month > 12)
            return new ValidationResult(false, "Month out of range.", "Month must be an integer between 1 and 12.");
        if (day < 1 || day > 31)
            return new ValidationResult(false, "Day out of range.", "Day must be between 1 and 31.");

        // 4. Calendar constraint check
        bool isLeap = IsLeapYear(year);
        int maxDays = GetDaysInMonth(month, year);

        if (day > maxDays)
        {
            string monthName = GetMonthName(month);
            if (month == 2)
            {
                string leapExplanation = isLeap
                    ? $"Year {year} is a Leap Year, so February has a maximum of 29 days."
                    : $"Year {year} is NOT a Leap Year, so February has a maximum of 28 days.";
                return new ValidationResult(false, $"Invalid date for {monthName}.", $"{leapExplanation} You entered {day}.");
            }
            else
            {
                return new ValidationResult(false, $"Invalid date for {monthName}.", $"{monthName} has a maximum of {maxDays} days. You entered {day}.");
            }
        }

        // 5. Success metadata
        DateTime dateTime = new DateTime(year, month, day);
        string dayOfWeek = dateTime.ToString("dddd");
        string formattedDate = $"{day:D2}/{month:D2}/{year:D4}";

        string successDetails = $"The date {formattedDate} is a valid calendar date.\nIt falls on a {dayOfWeek}.";
        if (isLeap)
        {
            successDetails += $"\n(Year {year} is a Leap Year!)";
        }

        return new ValidationResult(true, "Valid Date!", successDetails);
    }

    private static bool IsLeapYear(int year)
    {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
    }

    private static int GetDaysInMonth(int month, int year)
    {
        if (month == 2)
        {
            return IsLeapYear(year) ? 29 : 28;
        }
        if (month == 4 || month == 6 || month == 9 || month == 11)
        {
            return 30;
        }
        return 31;
    }

    private static string GetMonthName(int month)
    {
        return System.Globalization.CultureInfo.CurrentCulture.DateTimeFormat.GetMonthName(month);
    }
}
