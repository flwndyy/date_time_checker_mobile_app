namespace DateTimeChecker
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lblTitle = new System.Windows.Forms.Label();
            this.lblSubtitle = new System.Windows.Forms.Label();
            
            this.lblDay = new System.Windows.Forms.Label();
            this.txtDay = new System.Windows.Forms.TextBox();
            
            this.lblMonth = new System.Windows.Forms.Label();
            this.txtMonth = new System.Windows.Forms.TextBox();
            
            this.lblYear = new System.Windows.Forms.Label();
            this.txtYear = new System.Windows.Forms.TextBox();
            
            this.btnClear = new System.Windows.Forms.Button();
            this.btnCheck = new System.Windows.Forms.Button();
            
            this.pnlResult = new System.Windows.Forms.Panel();
            this.lblResultTitle = new System.Windows.Forms.Label();
            this.lblResultText = new System.Windows.Forms.Label();
            
            this.pnlResult.SuspendLayout();
            this.SuspendLayout();
            
            // 
            // lblTitle
            // 
            this.lblTitle.AutoSize = true;
            this.lblTitle.Font = new System.Drawing.Font("Segoe UI Semibold", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.lblTitle.ForeColor = System.Drawing.Color.FromArgb(137, 180, 250);
            this.lblTitle.Location = new System.Drawing.Point(26, 20);
            this.lblTitle.Name = "lblTitle";
            this.lblTitle.Size = new System.Drawing.Size(262, 32);
            this.lblTitle.TabIndex = 0;
            this.lblTitle.Text = "📅 Date Time Checker";
            // 
            // lblSubtitle
            // 
            this.lblSubtitle.AutoSize = true;
            this.lblSubtitle.Font = new System.Drawing.Font("Segoe UI", 9.5f, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.lblSubtitle.ForeColor = System.Drawing.Color.FromArgb(166, 173, 200);
            this.lblSubtitle.Location = new System.Drawing.Point(30, 58);
            this.lblSubtitle.Name = "lblSubtitle";
            this.lblSubtitle.Size = new System.Drawing.Size(325, 17);
            this.lblSubtitle.TabIndex = 1;
            this.lblSubtitle.Text = "Verify if a given Day, Month (or Time), and Year are valid.";
            // 
            // lblDay
            // 
            this.lblDay.AutoSize = true;
            this.lblDay.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75f, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.lblDay.ForeColor = System.Drawing.Color.FromArgb(205, 214, 244);
            this.lblDay.Location = new System.Drawing.Point(30, 102);
            this.lblDay.Name = "lblDay";
            this.lblDay.Size = new System.Drawing.Size(102, 17);
            this.lblDay.TabIndex = 2;
            this.lblDay.Text = "Day / Date (1-31)";
            // 
            // txtDay
            // 
            this.txtDay.BackColor = System.Drawing.Color.FromArgb(49, 50, 68);
            this.txtDay.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtDay.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.txtDay.ForeColor = System.Drawing.Color.FromArgb(205, 214, 244);
            this.txtDay.Location = new System.Drawing.Point(30, 125);
            this.txtDay.Name = "txtDay";
            this.txtDay.Size = new System.Drawing.Size(145, 29);
            this.txtDay.TabIndex = 3;
            this.txtDay.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // lblMonth
            // 
            this.lblMonth.AutoSize = true;
            this.lblMonth.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75f, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.lblMonth.ForeColor = System.Drawing.Color.FromArgb(205, 214, 244);
            this.lblMonth.Location = new System.Drawing.Point(202, 102);
            this.lblMonth.Name = "lblMonth";
            this.lblMonth.Size = new System.Drawing.Size(127, 17);
            this.lblMonth.TabIndex = 4;
            this.lblMonth.Text = "Month / Time (1-12)";
            // 
            // txtMonth
            // 
            this.txtMonth.BackColor = System.Drawing.Color.FromArgb(49, 50, 68);
            this.txtMonth.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtMonth.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.txtMonth.ForeColor = System.Drawing.Color.FromArgb(205, 214, 244);
            this.txtMonth.Location = new System.Drawing.Point(202, 125);
            this.txtMonth.Name = "txtMonth";
            this.txtMonth.Size = new System.Drawing.Size(145, 29);
            this.txtMonth.TabIndex = 5;
            this.txtMonth.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // lblYear
            // 
            this.lblYear.AutoSize = true;
            this.lblYear.Font = new System.Drawing.Font("Segoe UI Semibold", 9.75f, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.lblYear.ForeColor = System.Drawing.Color.FromArgb(205, 214, 244);
            this.lblYear.Location = new System.Drawing.Point(375, 102);
            this.lblYear.Name = "lblYear";
            this.lblYear.Size = new System.Drawing.Size(95, 17);
            this.lblYear.TabIndex = 6;
            this.lblYear.Text = "Year (1-9999)";
            // 
            // txtYear
            // 
            this.txtYear.BackColor = System.Drawing.Color.FromArgb(49, 50, 68);
            this.txtYear.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.txtYear.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.txtYear.ForeColor = System.Drawing.Color.FromArgb(205, 214, 244);
            this.txtYear.Location = new System.Drawing.Point(375, 125);
            this.txtYear.Name = "txtYear";
            this.txtYear.Size = new System.Drawing.Size(145, 29);
            this.txtYear.TabIndex = 7;
            this.txtYear.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // btnClear
            // 
            this.btnClear.BackColor = System.Drawing.Color.FromArgb(49, 50, 68);
            this.btnClear.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnClear.FlatAppearance.BorderSize = 0;
            this.btnClear.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(69, 71, 90);
            this.btnClear.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(59, 60, 80);
            this.btnClear.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClear.Font = new System.Drawing.Font("Segoe UI Semibold", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnClear.ForeColor = System.Drawing.Color.FromArgb(245, 224, 220);
            this.btnClear.Location = new System.Drawing.Point(30, 185);
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(145, 42);
            this.btnClear.TabIndex = 8;
            this.btnClear.Text = "🧹 Clear All";
            this.btnClear.UseVisualStyleBackColor = false;
            this.btnClear.Click += new System.EventHandler(this.BtnClear_Click);
            // 
            // btnCheck
            // 
            this.btnCheck.BackColor = System.Drawing.Color.FromArgb(166, 227, 161);
            this.btnCheck.Cursor = System.Windows.Forms.Cursors.Hand;
            this.btnCheck.FlatAppearance.BorderSize = 0;
            this.btnCheck.FlatAppearance.MouseDownBackColor = System.Drawing.Color.FromArgb(130, 200, 130);
            this.btnCheck.FlatAppearance.MouseOverBackColor = System.Drawing.Color.FromArgb(185, 240, 180);
            this.btnCheck.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCheck.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnCheck.ForeColor = System.Drawing.Color.FromArgb(17, 17, 27);
            this.btnCheck.Location = new System.Drawing.Point(202, 185);
            this.btnCheck.Name = "btnCheck";
            this.btnCheck.Size = new System.Drawing.Size(318, 42);
            this.btnCheck.TabIndex = 9;
            this.btnCheck.Text = "✔ Check Validity";
            this.btnCheck.UseVisualStyleBackColor = false;
            this.btnCheck.Click += new System.EventHandler(this.BtnCheck_Click);
            // 
            // pnlResult
            // 
            this.pnlResult.BackColor = System.Drawing.Color.FromArgb(49, 50, 68);
            this.pnlResult.Controls.Add(this.lblResultTitle);
            this.pnlResult.Controls.Add(this.lblResultText);
            this.pnlResult.Location = new System.Drawing.Point(30, 255);
            this.pnlResult.Name = "pnlResult";
            this.pnlResult.Padding = new System.Windows.Forms.Padding(15);
            this.pnlResult.Size = new System.Drawing.Size(490, 150);
            this.pnlResult.TabIndex = 10;
            // 
            // lblResultTitle
            // 
            this.lblResultTitle.AutoSize = true;
            this.lblResultTitle.Font = new System.Drawing.Font("Segoe UI Semibold", 11.25f, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.lblResultTitle.ForeColor = System.Drawing.Color.FromArgb(205, 214, 244);
            this.lblResultTitle.Location = new System.Drawing.Point(15, 15);
            this.lblResultTitle.Name = "lblResultTitle";
            this.lblResultTitle.Size = new System.Drawing.Size(134, 20);
            this.lblResultTitle.TabIndex = 0;
            this.lblResultTitle.Text = "Ready to Validate";
            // 
            // lblResultText
            // 
            this.lblResultText.Font = new System.Drawing.Font("Segoe UI", 9.75f, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.lblResultText.ForeColor = System.Drawing.Color.FromArgb(166, 173, 200);
            this.lblResultText.Location = new System.Drawing.Point(15, 45);
            this.lblResultText.Name = "lblResultText";
            this.lblResultText.Size = new System.Drawing.Size(460, 90);
            this.lblResultText.TabIndex = 1;
            this.lblResultText.Text = "Fill in the Day, Month/Time, and Year fields above, then press \'Check Validity\' to verify the calendar date.";
            // 
            // Form1
            // 
            this.AcceptButton = this.btnCheck;
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.FromArgb(30, 30, 46);
            this.ClientSize = new System.Drawing.Size(550, 435);
            this.Controls.Add(this.pnlResult);
            this.Controls.Add(this.btnCheck);
            this.Controls.Add(this.btnClear);
            this.Controls.Add(this.txtYear);
            this.Controls.Add(this.lblYear);
            this.Controls.Add(this.txtMonth);
            this.Controls.Add(this.lblMonth);
            this.Controls.Add(this.txtDay);
            this.Controls.Add(this.lblDay);
            this.Controls.Add(this.lblSubtitle);
            this.Controls.Add(this.lblTitle);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.Name = "Form1";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Date Time Checker";
            this.pnlResult.ResumeLayout(false);
            this.pnlResult.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lblTitle;
        private System.Windows.Forms.Label lblSubtitle;
        
        private System.Windows.Forms.Label lblDay;
        private System.Windows.Forms.TextBox txtDay;
        
        private System.Windows.Forms.Label lblMonth;
        private System.Windows.Forms.TextBox txtMonth;
        
        private System.Windows.Forms.Label lblYear;
        private System.Windows.Forms.TextBox txtYear;
        
        private System.Windows.Forms.Button btnClear;
        private System.Windows.Forms.Button btnCheck;
        
        private System.Windows.Forms.Panel pnlResult;
        private System.Windows.Forms.Label lblResultTitle;
        private System.Windows.Forms.Label lblResultText;
    }
}
