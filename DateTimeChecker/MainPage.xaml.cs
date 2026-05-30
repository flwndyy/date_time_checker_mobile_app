using DateTimeChecker.ViewModels;

namespace DateTimeChecker;

public partial class MainPage : ContentPage
{
	public MainPage()
	{
		InitializeComponent();
		BindingContext = new MainPageViewModel();
	}
}
