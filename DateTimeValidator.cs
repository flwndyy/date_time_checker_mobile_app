using System;

namespace DateTimeChecker
{
    public class ValidationResult
    {
        public bool IsValid { get; }
        public string Message { get; }
        public string Details { get; }

        public ValidationResult(bool isValid, string message, string details = "")
        {
            IsValid = isValid;
            Message = message;
            Details = details;
        }
    }

    public static class DateTimeValidator
    {
        /// <summary>
        /// Validates a date given day, month (or "time"), and year inputs.
        /// </summary>
        public static ValidationResult Validate(string dayInput, string monthOrTimeInput, string yearInput)
        {
            // 1. Check for empty inputs
            if (string.IsNullOrWhiteSpace(dayInput))
                return new ValidationResult(false, "Day cannot be empty.", "Please enter a valid day of the month.");
            if (string.IsNullOrWhiteSpace(monthOrTimeInput))
                return new ValidationResult(false, "Month cannot be empty.", "Please enter a valid month (1-12).");
            if (string.IsNullOrWhiteSpace(yearInput))
                return new ValidationResult(false, "Year cannot be empty.", "Please enter a valid year.");

            // Trim inputs
            dayInput = dayInput.Trim();
            monthOrTimeInput = monthOrTimeInput.Trim();
            yearInput = yearInput.Trim();

            // 2. Parse Year
            if (!int.TryParse(yearInput, out int year))
            {
                return new ValidationResult(false, "Invalid Year format.", "Year must be a valid integer number.");
            }
            if (year < 1 || year > 9999)
            {
                return new ValidationResult(false, "Year out of range.", "Year must be between 1 and 9999.");
            }

            // 3. Parse Month
            // If monthOrTimeInput contains time elements (like HH:mm), let's extract the month or parse it gracefully.
            // But if it's standard, it should be an integer representing the month.
            int month = 0;
            bool isMonthParsed = int.TryParse(monthOrTimeInput, out month);

            if (!isMonthParsed)
            {
                // Try parsing English month names or abbreviations
                string mLower = monthOrTimeInput.ToLower();
                if (mLower == "jan" || mLower == "january") month = 1;
                else if (mLower == "feb" || mLower == "february") month = 2;
                else if (mLower == "mar" || mLower == "march") month = 3;
                else if (mLower == "apr" || mLower == "april") month = 4;
                else if (mLower == "may") month = 5;
                else if (mLower == "jun" || mLower == "june") month = 6;
                else if (mLower == "jul" || mLower == "july") month = 7;
                else if (mLower == "aug" || mLower == "august") month = 8;
                else if (mLower == "sep" || mLower == "september") month = 9;
                else if (mLower == "oct" || mLower == "october") month = 10;
                else if (mLower == "nov" || mLower == "november") month = 11;
                else if (mLower == "dec" || mLower == "december") month = 12;
                else
                {
                    // Maybe the user entered a time in this textbox as they typed "date, time, year".
                    // Let's check if we can extract a month or if they just put a time string like "12:30".
                    // If they put "12:30", let's assume month 1 or default, but give a friendly hint.
                    if (monthOrTimeInput.Contains(":"))
                    {
                        return new ValidationResult(false, 
                            "Month box contains a Time string.", 
                            "It looks like you typed a time (e.g. " + monthOrTimeInput + ") in the Month box! In standard date checkers, this field expects the Month (1-12). Please input a number from 1 to 12.");
                    }
                    return new ValidationResult(false, "Invalid Month format.", "Month must be a valid integer (1-12) or a standard month name.");
                }
            }

            if (month < 1 || month > 12)
            {
                return new ValidationResult(false, "Month out of range.", "Month must be an integer between 1 and 12.");
            }

            // 4. Parse Day
            if (!int.TryParse(dayInput, out int day))
            {
                return new ValidationResult(false, "Invalid Day format.", "Day must be a valid integer number.");
            }
            if (day < 1 || day > 31)
            {
                return new ValidationResult(false, "Day out of range.", "Day must be between 1 and 31.");
            }

            // 5. Calendar constraints check (Days in Month & Leap Years)
            bool isLeapYear = IsLeapYear(year);
            int maxDays = GetDaysInMonth(month, year);

            if (day > maxDays)
            {
                string monthName = GetMonthName(month);
                if (month == 2)
                {
                    string leapExplanation = isLeapYear 
                        ? $"Year {year} is a Leap Year, so February has a maximum of 29 days." 
                        : $"Year {year} is NOT a Leap Year, so February has a maximum of 28 days.";
                    return new ValidationResult(false, 
                        $"Invalid date for {monthName}.", 
                        $"{leapExplanation} You entered {day}.");
                }
                else
                {
                    return new ValidationResult(false, 
                        $"Invalid date for {monthName}.", 
                        $"{monthName} has a maximum of {maxDays} days. You entered {day}.");
                }
            }

            // 6. Success!
            string formattedDate = $"{day:D2}/{month:D2}/{year:D4}";
            string dayOfWeek = new DateTime(year, month, day).ToString("dddd");
            string successDetails = $"The date {formattedDate} is a valid calendar date.\nIt falls on a {dayOfWeek}.";
            if (isLeapYear)
            {
                successDetails += $" (Year {year} is a Leap Year!)";
            }

            return new ValidationResult(true, "Valid Date!", successDetails);
        }

        public static bool IsLeapYear(int year)
        {
            return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
        }

        public static int GetDaysInMonth(int month, int year)
        {
            switch (month)
            {
                case 2:
                    return IsLeapYear(year) ? 29 : 28;
                case 4:
                case 6:
                case 9:
                case 11:
                    return 30;
                default:
                    return 31;
            }
        }

        private static string GetMonthName(int month)
        {
            string[] names = { "", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" };
            return names[month];
        }
    }
}
