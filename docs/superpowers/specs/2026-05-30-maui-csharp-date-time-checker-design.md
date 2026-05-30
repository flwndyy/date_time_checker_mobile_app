# Design Spec: .NET MAUI MVVM Date Time Checker App (C#)

**Date**: 2026-05-30  
**Status**: APPROVED  
**Author**: Antigravity AI Coding Assistant  

---

## 1. Overview & Objective
The goal is to implement a highly polished, cross-platform .NET MAUI mobile application in C# that validates calendar date correctness. Based on user design brainstorming, the app will utilize **Model-View-ViewModel (MVVM)** architecture, featuring 3 side-by-side Entry fields (Day, Month, Year) with numeric keyboard restrictions, side-by-side action buttons, and a centered glassmorphic overlay popup result card with status-specific neon shadows and borders.

---

## 2. File & Project Structure
The codebase will follow a clean MVVM directory decomposition:
```
DateTimeChecker/
├── Models/
│   ├── ValidationResult.cs    (Holds isValid, message, and details status fields)
│   └── DateValidator.cs       (Core validation calendar checks)
├── ViewModels/
│   ├── BaseViewModel.cs       (Implements INotifyPropertyChanged support)
│   └── MainPageViewModel.cs   (Handles active bindings, input states, and commands)
└── Views/
    └── MainPage.xaml          (Main XAML view, glass entries, buttons, popup overlay)
```

---

## 3. The Model: Date Validation Engine (`DateValidator.cs`)
The validation engine will be coded in pure C#:

```csharp
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
```

---

## 4. The ViewModel: State & Bindings (`MainPageViewModel.cs`)
Exposes properties and C# Commands using standard community toolkit patterns:

```csharp
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Windows.Input;
using DateTimeChecker.Models;

namespace DateTimeChecker.ViewModels;

public class MainPageViewModel : INotifyPropertyChanged
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

    public event PropertyChangedEventHandler? PropertyChanged;

    protected void SetProperty<T>(ref T storage, T value, [CallerMemberName] string propertyName = null!)
    {
        if (Equals(storage, value)) return;
        storage = value;
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }
}
```

---

## 5. The View: Glassmorphic UI Layout (`MainPage.xaml`)
The XAML view defines a slate background, entry widgets, action buttons, and overlay dialog:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             xmlns:vm="clr-namespace:DateTimeChecker.ViewModels"
             x:Class="DateTimeChecker.Views.MainPage"
             BackgroundColor="#0F172A">

    <ContentPage.BindingContext>
        <vm:MainPageViewModel />
    </ContentPage.BindingContext>

    <Grid>
        <!-- Background Layer -->
        <ScrollView Padding="24, 40">
            <VerticalStackLayout Spacing="32">
                
                <!-- Title Block -->
                <VerticalStackLayout Spacing="8">
                    <Label Text="📅 Date Time Checker"
                           TextColor="#89B4FA"
                           FontSize="28"
                           FontAttributes="Bold"
                           HorizontalOptions="Center" />
                    <Label Text="Verify calendar date validity with premium C# MAUI MVVM feedback."
                           TextColor="#A6ADC8"
                           FontSize="14"
                           HorizontalOptions="Center"
                           HorizontalTextAlignment="Center" />
                </VerticalStackLayout>

                <!-- Input Grid Row -->
                <Grid ColumnDefinitions="*, 16, *, 16, *" Padding="0, 16">
                    
                    <!-- Day Entry -->
                    <VerticalStackLayout Grid.Column="0" Spacing="8">
                        <Label Text="Day" TextColor="#CDD6F4" FontAttributes="Bold" HorizontalOptions="Center" />
                        <Border Stroke="#1FCDD6F4" StrokeThickness="1.5" BackgroundColor="#0FCDD6F4" StrokeShape="RoundRectangle 12">
                            <Entry Text="{Binding DayInput}" Keyboard="Numeric" HorizontalTextAlignment="Center" TextColor="#CDD6F4" FontSize="18" HeightRequest="52" Placeholder="30" PlaceholderColor="#585B70"/>
                        </Border>
                    </VerticalStackLayout>

                    <!-- Month Entry -->
                    <VerticalStackLayout Grid.Column="2" Spacing="8">
                        <Label Text="Month" TextColor="#CDD6F4" FontAttributes="Bold" HorizontalOptions="Center" />
                        <Border Stroke="#1FCDD6F4" StrokeThickness="1.5" BackgroundColor="#0FCDD6F4" StrokeShape="RoundRectangle 12">
                            <Entry Text="{Binding MonthInput}" Keyboard="Numeric" HorizontalTextAlignment="Center" TextColor="#CDD6F4" FontSize="18" HeightRequest="52" Placeholder="5" PlaceholderColor="#585B70"/>
                        </Border>
                    </VerticalStackLayout>

                    <!-- Year Entry -->
                    <VerticalStackLayout Grid.Column="4" Spacing="8">
                        <Label Text="Year" TextColor="#CDD6F4" FontAttributes="Bold" HorizontalOptions="Center" />
                        <Border Stroke="#1FCDD6F4" StrokeThickness="1.5" BackgroundColor="#0FCDD6F4" StrokeShape="RoundRectangle 12">
                            <Entry Text="{Binding YearInput}" Keyboard="Numeric" HorizontalTextAlignment="Center" TextColor="#CDD6F4" FontSize="18" HeightRequest="52" Placeholder="2026" PlaceholderColor="#585B70"/>
                        </Border>
                    </VerticalStackLayout>
                </Grid>

                <!-- Action Button Block -->
                <Grid ColumnDefinitions="Auto, 16, *">
                    <!-- Clear -->
                    <Border Grid.Column="0" Stroke="#1FCDD6F4" StrokeThickness="1.5" BackgroundColor="#0FCDD6F4" StrokeShape="RoundRectangle 14">
                        <Button Text="🧹 Clear" Command="{Binding ClearCommand}" TextColor="#F5E0DC" FontAttributes="Bold" FontSize="15" WidthRequest="110" HeightRequest="52" BackgroundColor="Transparent"/>
                    </Border>

                    <!-- Check -->
                    <Border Grid.Column="2" Stroke="Transparent" BackgroundColor="#10B981" StrokeShape="RoundRectangle 14">
                        <Button Text="✔ Check Validity" Command="{Binding CheckCommand}" TextColor="#0F172A" FontAttributes="Bold" FontSize="16" HeightRequest="52" BackgroundColor="Transparent"/>
                    </Border>
                </Grid>

            </VerticalStackLayout>
        </ScrollView>

        <!-- Floating Glassmorphic Scrim & Dialog Modal Layer -->
        <Grid BackgroundColor="#66000000" IsVisible="{Binding IsDialogVisible}">
            <Border WidthRequest="320"
                    VerticalOptions="Center"
                    HorizontalOptions="Center"
                    StrokeThickness="1.5"
                    StrokeShape="RoundRectangle 24"
                    Padding="24"
                    BackgroundColor="#441E293B">
                <!-- Color binds depending on validation result success -->
                <Border.Triggers>
                    <DataTrigger TargetType="Border" Binding="{Binding IsValidationSuccess}" Value="True">
                        <Setter Property="Stroke" Value="#10B981" />
                    </DataTrigger>
                    <DataTrigger TargetType="Border" Binding="{Binding IsValidationSuccess}" Value="False">
                        <Setter Property="Stroke" Value="#EF4444" />
                    </DataTrigger>
                </Border.Triggers>

                <VerticalStackLayout Spacing="16" HorizontalOptions="Center">
                    <!-- Status Icon & Title -->
                    <Label Text="{Binding DialogTitle}" FontSize="22" FontAttributes="Bold" HorizontalOptions="Center">
                        <Label.Triggers>
                            <DataTrigger TargetType="Label" Binding="{Binding IsValidationSuccess}" Value="True">
                                <Setter Property="TextColor" Value="#10B981" />
                            </DataTrigger>
                            <DataTrigger TargetType="Label" Binding="{Binding IsValidationSuccess}" Value="False">
                                <Setter Property="TextColor" Value="#EF4444" />
                            </DataTrigger>
                        </Label.Triggers>
                    </Label>

                    <!-- Outcome messages -->
                    <Label Text="{Binding DialogMessage}" TextColor="#CDD6F4" FontSize="16" FontAttributes="Bold" HorizontalOptions="Center" HorizontalTextAlignment="Center"/>
                    <Label Text="{Binding DialogDetails}" TextColor="#A6ADC8" FontSize="14" HorizontalOptions="Center" HorizontalTextAlignment="Center"/>

                    <!-- Done Button -->
                    <Border Stroke="#1FCDD6F4" StrokeThickness="1.5" BackgroundColor="#0FCDD6F4" StrokeShape="RoundRectangle 12" Margin="0,16,0,0">
                        <Button Text="Done" Command="{Binding DismissCommand}" TextColor="#CDD6F4" FontAttributes="Bold" HeightRequest="48" WidthRequest="200" BackgroundColor="Transparent"/>
                    </Border>
                </VerticalStackLayout>
            </Border>
        </Grid>
    </Grid>
</ContentPage>
```

---

## 6. Verification & Test Plan
- **Manual Verification**:
  - Verify numeric keyboard (`Keyboard="Numeric"`) triggers on entry fields for iOS and Android.
  - Assert that tapping Clear resets inputs, and tapping Check triggers the floating centered border-glow dialog.
- **Automated Tests**:
  - Run C# Unit Tests (`dotnet test`) verifying `DateValidator.Validate()` against edge-case date entries (e.g. leap years and month limits).
