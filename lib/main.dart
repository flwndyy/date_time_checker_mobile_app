import 'package:flutter/material.dart';
import 'dart:ui';
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
    });
    // Return focus to first field
    _dayFocusNode.requestFocus();
  }

  void _checkValidity() {
    // Hide keyboard
    FocusScope.of(context).unfocus();

    final result = DateTimeValidator.validate(
      _dayController.text,
      _monthController.text,
      _yearController.text,
    );

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (BuildContext context) {
        final glowColor = result.isValid ? const Color(0xFF10B981) : const Color(0xFFEF4444);
        final title = result.isValid ? "Valid Date!" : "Validation Failed";
        final icon = result.isValid ? Icons.shield_outlined : Icons.warning_amber_outlined;

        return Center(
          child: SingleChildScrollView(
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0x1FCDD6F4),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: glowColor.withOpacity(0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: glowColor.withOpacity(0.15),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, size: 54, color: glowColor),
                        const SizedBox(height: 16),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: glowColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          result.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFCDD6F4),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          result.details,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.4,
                            color: Color(0xFFA6ADC8),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0x1FCDD6F4)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: const Color(0x0FCDD6F4),
                              foregroundColor: const Color(0xFFCDD6F4),
                            ),
                            child: const Text(
                              "Done",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                          textAlign: TextAlign.center,
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
                            fillColor: const Color(0x0FCDD6F4), // Glassmorphic fill
                            contentPadding: const EdgeInsets.symmetric(vertical: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0x1FCDD6F4), width: 1.0), // Glass border
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
                          keyboardType: TextInputType.number, // Set to numeric keyboard
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
                            fillColor: const Color(0x0FCDD6F4), // Glassmorphic fill
                            contentPadding: const EdgeInsets.symmetric(vertical: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0x1FCDD6F4), width: 1.0), // Glass border
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
                            fillColor: const Color(0x0FCDD6F4), // Glassmorphic fill
                            contentPadding: const EdgeInsets.symmetric(vertical: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Color(0x1FCDD6F4), width: 1.0), // Glass border
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
                          color: Color(0x1FCDD6F4), // Reflective glass hairline border
                          width: 1.5,
                        ),
                        backgroundColor: const Color(0x0FCDD6F4), // Glass fill
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

                  // Check Button (Gradient Accent with Glow Shadow)
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
                            color: const Color(0xFF10B981).withOpacity(0.4), // Enhanced neon glow
                            blurRadius: 12,
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
            ],
          ),
        ),
      ),
    );
  }
}
