import 'package:flutter/material.dart';
import 'date_time_validator.dart';

void main() {
  runApp(const DateTimeCheckerApp());
}

class DateTimeCheckerApp extends StatelessWidget {
  const DateTimeCheckerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Time Checker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF89B4FA),
          brightness: Brightness.dark,
          primary: const Color(0xFF89B4FA),
          surface: const Color(0xFF1E293B),
          background: const Color(0xFF0F172A),
        ),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const DateTimeCheckerHome(),
    );
  }
}

class DateTimeCheckerHome extends StatefulWidget {
  const DateTimeCheckerHome({super.key});

  @override
  State<DateTimeCheckerHome> createState() => _DateTimeCheckerHomeState();
}

class _DateTimeCheckerHomeState extends State<DateTimeCheckerHome> {
  // Input controllers
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  // Focus nodes to manage input focus states and tab triggers
  final FocusNode _dayFocusNode = FocusNode();
  final FocusNode _monthFocusNode = FocusNode();
  final FocusNode _yearFocusNode = FocusNode();

  // Validation Result State
  ValidationResult? _validationResult;

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _dayFocusNode.dispose();
    _monthFocusNode.dispose();
    _yearFocusNode.dispose();
    super.dispose();
  }

  void _clearAll() {
    setState(() {
      _dayController.clear();
      _monthController.clear();
      _yearController.clear();
      _validationResult = null;
    });
    // Return focus to first field
    _dayFocusNode.requestFocus();
  }

  void _checkValidity() {
    // Hide keyboard
    FocusScope.of(context).unfocus();

    setState(() {
      _validationResult = DateTimeValidator.validate(
        _dayController.text,
        _monthController.text,
        _yearController.text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Theme Colors
    const cardNeutralBg = Color(0xFF1E293B);
    const cardNeutralText = Color(0xFFCDD6F4);
    const cardNeutralSubText = Color(0xFFA6ADC8);

    const cardValidBg = Color(0xFF143F2E);
    const cardValidText = Color(0xFF34D399);

    const cardInvalidBg = Color(0xFF451A23);
    const cardInvalidText = Color(0xFFF87171);

    // Get current result colors
    Color currentCardBg = cardNeutralBg;
    Color currentTitleColor = cardNeutralText;
    Color currentTextColor = cardNeutralSubText;
    String currentTitle = "Ready to Validate";
    String currentMessage =
        "Fill in the Day, Month/Time, and Year fields above, then tap 'Check Validity' to verify the calendar date.";

    if (_validationResult != null) {
      if (_validationResult!.isValid) {
        currentCardBg = cardValidBg;
        currentTitleColor = cardValidText;
        currentTextColor = cardValidText;
        currentTitle = "✅ Validation Succeeded";
        currentMessage =
            "${_validationResult!.message}\n\n${_validationResult!.details}";
      } else {
        currentCardBg = cardInvalidBg;
        currentTitleColor = cardInvalidText;
        currentTextColor = cardInvalidText;
        currentTitle = "❌ Validation Failed";
        currentMessage =
            "${_validationResult!.message}\n\n${_validationResult!.details}";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '📅 Date Time Checker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF89B4FA),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome / Subtitle
              const Text(
                "Calendar Validator",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Verify if a given Day, Month (or Time), and Year form a valid calendar date.",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFA6ADC8),
                ),
              ),
              const SizedBox(height: 32),

              // Inputs Grid (Three side-by-side TextFields)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Day Field
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Day / Date",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFCDD6F4),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _dayController,
                          focusNode: _dayFocusNode,
                          textAlign: Alignment.center.x == 0 ? TextAlign.center : TextAlign.center,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) => _monthFocusNode.requestFocus(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFCDD6F4),
                          ),
                          decoration: InputDecoration(
                            hintText: '30',
                            hintStyle: const TextStyle(color: Color(0xFF585B70)),
                            filled: true,
                            fillColor: const Color(0xFF1E293B),
                            contentPadding: const EdgeInsets.symmetric(vertical: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFF89B4FA),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Month / Time Field
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Month / Time",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFCDD6F4),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _monthController,
                          focusNode: _monthFocusNode,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (_) => _yearFocusNode.requestFocus(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFCDD6F4),
                          ),
                          decoration: InputDecoration(
                            hintText: '5',
                            hintStyle: const TextStyle(color: Color(0xFF585B70)),
                            filled: true,
                            fillColor: const Color(0xFF1E293B),
                            contentPadding: const EdgeInsets.symmetric(vertical: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFF89B4FA),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Year Field
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Year",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFCDD6F4),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _yearController,
                          focusNode: _yearFocusNode,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _checkValidity(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFCDD6F4),
                          ),
                          decoration: InputDecoration(
                            hintText: '2026',
                            hintStyle: const TextStyle(color: Color(0xFF585B70)),
                            filled: true,
                            fillColor: const Color(0xFF1E293B),
                            contentPadding: const EdgeInsets.symmetric(vertical: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFF89B4FA),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Buttons Section
              Row(
                children: [
                  // Clear Button
                  SizedBox(
                    height: 52,
                    child: OutlinedButton(
                      onPressed: _clearAll,
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        side: const BorderSide(
                          color: Color(0xFF313244),
                          width: 1.5,
                        ),
                        backgroundColor: const Color(0xFF1E293B),
                        foregroundColor: const Color(0xFFF5E0DC),
                      ),
                      child: const Text(
                        "🧹 Clear",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Check Button (Gradient Accent)
                  Expanded(
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF10B981),
                            Color(0xFF14B8A6),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF10B981).withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _checkValidity,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: const Color(0xFF0F172A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          "✔ Check Validity",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),

              // Dynamic Animated Result Card
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: currentCardBg,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentTitle,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: currentTitleColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      currentMessage,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: currentTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
