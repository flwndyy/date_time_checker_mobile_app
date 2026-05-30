using System.Windows.Input;
using DateTimeChecker.Models;

namespace DateTimeChecker.ViewModels;

public class MainPageViewModel : BaseViewModel
{
    private string _dayInput = string.Empty;
    private string _monthInput = string.Empty;
    private string _yearInput = string.Empty;
    private bool _isDialogVisible;
    private bool _isValidationSuccess;
    private string _dialogTitle = string.Empty;
    private string _dialogMessage = string.Empty;
    private string _dialogDetails = string.Empty;

    public string DayInput
    {
        get => _dayInput;
        set => SetProperty(ref _dayInput, value);
    }

    public string MonthInput
    {
        get => _monthInput;
        set => SetProperty(ref _monthInput, value);
    }

    public string YearInput
    {
        get => _yearInput;
        set => SetProperty(ref _yearInput, value);
    }

    public bool IsDialogVisible
    {
        get => _isDialogVisible;
        set => SetProperty(ref _isDialogVisible, value);
    }

    public bool IsValidationSuccess
    {
        get => _isValidationSuccess;
        set => SetProperty(ref _isValidationSuccess, value);
    }

    public string DialogTitle
    {
        get => _dialogTitle;
        set => SetProperty(ref _dialogTitle, value);
    }

    public string DialogMessage
    {
        get => _dialogMessage;
        set => SetProperty(ref _dialogMessage, value);
    }

    public string DialogDetails
    {
        get => _dialogDetails;
        set => SetProperty(ref _dialogDetails, value);
    }

    public ICommand CheckCommand { get; }
    public ICommand ClearCommand { get; }
    public ICommand DismissCommand { get; }

    public MainPageViewModel()
    {
        CheckCommand = new Command(OnCheck);
        ClearCommand = new Command(OnClear);
        DismissCommand = new Command(() => IsDialogVisible = false);
    }

    private void OnCheck()
    {
        var result = DateValidator.Validate(DayInput, MonthInput, YearInput);

        DialogTitle = result.IsValid ? "Valid Date!" : "Validation Failed";
        DialogMessage = result.Message;
        DialogDetails = result.Details;
        IsValidationSuccess = result.IsValid;
        IsDialogVisible = true;
    }

    private void OnClear()
    {
        DayInput = string.Empty;
        MonthInput = string.Empty;
        YearInput = string.Empty;
        IsDialogVisible = false;
    }
}
public class Command : ICommand
{
    private readonly Action _execute;
    public event EventHandler? CanExecuteChanged { add { } remove { } }

    public Command(Action execute)
    {
        _execute = execute;
    }

    public bool CanExecute(object? parameter) => true;

    public void Execute(object? parameter)
    {
        _execute();
    }
}
