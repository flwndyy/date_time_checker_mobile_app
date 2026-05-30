using System;
using System.Drawing;
using System.Windows.Forms;

namespace DateTimeChecker
{
    public partial class Form1 : Form
    {
        // Define color scheme colors
        private readonly Color ThemeBg = Color.FromArgb(30, 30, 46);
        
        // Base dark inputs
        private readonly Color InputBg = Color.FromArgb(49, 50, 68);
        private readonly Color InputFocusBg = Color.FromArgb(69, 71, 90);
        private readonly Color TextColor = Color.FromArgb(205, 214, 244);
        private readonly Color TextMutedColor = Color.FromArgb(166, 173, 200);

        // Result Card colors - Neutral
        private readonly Color CardNeutralBg = Color.FromArgb(49, 50, 68);
        private readonly Color CardNeutralText = Color.FromArgb(205, 214, 244);
        private readonly Color CardNeutralSubText = Color.FromArgb(166, 173, 200);

        // Result Card colors - Valid
        private readonly Color CardValidBg = Color.FromArgb(46, 68, 58);
        private readonly Color CardValidText = Color.FromArgb(166, 227, 161);

        // Result Card colors - Invalid
        private readonly Color CardInvalidBg = Color.FromArgb(69, 46, 52);
        private readonly Color CardInvalidText = Color.FromArgb(243, 139, 168);

        public Form1()
        {
            InitializeComponent();
            
            // Wire up premium micro-animations/transitions
            WireTextBoxTransitions();
            
            // Initial reset to default state
            ResetResultCard();
        }

        private void WireTextBoxTransitions()
        {
            // Day Textbox focus transitions
            txtDay.Enter += (s, e) => txtDay.BackColor = InputFocusBg;
            txtDay.Leave += (s, e) => txtDay.BackColor = InputBg;

            // Month/Time Textbox focus transitions
            txtMonth.Enter += (s, e) => txtMonth.BackColor = InputFocusBg;
            txtMonth.Leave += (s, e) => txtMonth.BackColor = InputBg;

            // Year Textbox focus transitions
            txtYear.Enter += (s, e) => txtYear.BackColor = InputFocusBg;
            txtYear.Leave += (s, e) => txtYear.BackColor = InputBg;
        }

        private void BtnClear_Click(object sender, EventArgs e)
        {
            // Clear inputs
            txtDay.Clear();
            txtMonth.Clear();
            txtYear.Clear();

            // Reset Result Card
            ResetResultCard();

            // Set focus back to first field
            txtDay.Focus();
        }

        private void BtnCheck_Click(object sender, EventArgs e)
        {
            // Perform validation using the robust engine
            ValidationResult result = DateTimeValidator.Validate(
                txtDay.Text, 
                txtMonth.Text, 
                txtYear.Text
            );

            // Dynamically update the results panel with smooth theme transition
            if (result.IsValid)
            {
                pnlResult.BackColor = CardValidBg;
                lblResultTitle.ForeColor = CardValidText;
                lblResultText.ForeColor = CardValidText;
                
                lblResultTitle.Text = "✅ Validation Succeeded (Valid Date)";
                lblResultText.Text = result.Message + "\n\n" + result.Details;
            }
            else
            {
                pnlResult.BackColor = CardInvalidBg;
                lblResultTitle.ForeColor = CardInvalidText;
                lblResultText.ForeColor = CardInvalidText;

                lblResultTitle.Text = "❌ Validation Failed (Invalid Date)";
                lblResultText.Text = result.Message + "\n\n" + result.Details;
            }
        }

        private void ResetResultCard()
        {
            pnlResult.BackColor = CardNeutralBg;
            lblResultTitle.ForeColor = CardNeutralText;
            lblResultText.ForeColor = CardNeutralSubText;

            lblResultTitle.Text = "Ready to Validate";
            lblResultText.Text = "Fill in the Day, Month/Time, and Year fields above, then press 'Check Validity' to verify the calendar date.";
        }
    }
}
