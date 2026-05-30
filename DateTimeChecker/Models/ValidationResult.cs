namespace DateTimeChecker.Models;

public class ValidationResult
{
    public bool IsValid { get; }
    public string Message { get; }
    public string Details { get; }

    public ValidationResult(bool isValid, string message, string details)
    {
        IsValid = isValid;
        Message = message;
        Details = details;
    }
}
