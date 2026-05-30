using Xunit;
using DateTimeChecker.Models;

namespace DateTimeChecker.Tests;

public class DateValidatorTests
{
    [Theory]
    [InlineData("29", "2", "2024", true)]  // Leap Year
    [InlineData("29", "2", "2026", false)] // Non-Leap Year
    [InlineData("31", "11", "2026", false)] // November has 30 days
    [InlineData("30", "11", "2026", true)]  // Valid date
    [InlineData("", "5", "2026", false)]    // Empty day
    [InlineData("15", "", "2026", false)]   // Empty month
    [InlineData("15", "5", "", false)]      // Empty year
    [InlineData("abc", "5", "2026", false)] // Invalid day format
    [InlineData("15", "xyz", "2026", false)] // Invalid month format
    [InlineData("15", "5", "abcd", false)]  // Invalid year format
    [InlineData("15", "5", "10000", false)] // Year out of range
    [InlineData("15", "13", "2026", false)] // Month out of range
    public void TestDateValidation(string day, string month, string year, bool expectedValid)
    {
        var result = DateValidator.Validate(day, month, year);
        Assert.Equal(expectedValid, result.IsValid);
    }
}
