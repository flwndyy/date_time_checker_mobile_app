using Xunit;
using DateTimeChecker.ViewModels;

namespace DateTimeChecker.Tests;

public class MainPageViewModelTests
{
    [Fact]
    public void TestClearCommandResetsState()
    {
        var vm = new MainPageViewModel();
        vm.DayInput = "15";
        vm.MonthInput = "5";
        vm.YearInput = "2026";

        vm.ClearCommand.Execute(null);

        Assert.Equal(string.Empty, vm.DayInput);
        Assert.Equal(string.Empty, vm.MonthInput);
        Assert.Equal(string.Empty, vm.YearInput);
        Assert.False(vm.IsDialogVisible);
    }

    [Fact]
    public void TestCheckCommandValidatesInputsAndOpensDialog()
    {
        var vm = new MainPageViewModel();
        vm.DayInput = "30";
        vm.MonthInput = "5";
        vm.YearInput = "2026";

        vm.CheckCommand.Execute(null);

        Assert.True(vm.IsDialogVisible);
        Assert.True(vm.IsValidationSuccess);
        Assert.Equal("Valid Date!", vm.DialogTitle);
    }
}
