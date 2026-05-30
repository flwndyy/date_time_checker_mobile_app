# Design Spec: Premium Glassmorphic Date Time Checker Mobile App

**Date**: 2026-05-30  
**Status**: APPROVED  
**Author**: Antigravity AI Coding Assistant  

---

## 1. Overview & Objective
The goal is to implement a highly polished, responsive, and modern Flutter mobile application that validates calendar date correctness. Based on user design brainstorming, the app will feature a **Premium Glassmorphic Dark theme** with an aesthetic and tactile design, utilizing 3 side-by-side numeric text fields (Day, Month, Year), "Clear" and "Check" action triggers, and displaying results in a **centered glassmorphic floating dialog modal** with realistic background blur.

---

## 2. Design System & Theme
We establish a cohesive visual token system to ensure premium visual quality:
- **Palette**:
  - `backgroundColor`: `Color(0xFF0F172A)` (Deep slate background)
  - `primaryAccent`: `Color(0xFF89B4FA)` (Soft pastel ice blue for active/focused elements)
  - `cardBackground`: `Color(0x0FCDD6F4)` (Ultra-translucent glass fill)
  - `successAccent`: `Color(0xFF10B981)` (Vibrant emerald green for positive feedback)
  - `successGlow`: `Color(0x3310B981)` (Neon green shadow glow)
  - `failureAccent`: `Color(0xFFEF4444)` (Vibrant coral/crimson red for validation failures)
  - `failureGlow`: `Color(0x33EF4444)` (Neon red shadow glow)
  - `glassBorder`: `Color(0x1FCDD6F4)` (Reflective hairline borders)
  - `textPrimary`: `Color(0xFFCDD6F4)` (High contrast crisp lavender white)
  - `textSecondary`: `Color(0xFFA6ADC8)` (Muted cool gray)
- **Glassmorphism Spec**:
  - Containers must utilize `BoxDecoration` with low-opacity white/gray backgrounds, thin semi-transparent borders, and deep, low-opacity shadows.
  - Interactive overlay components must use `BackdropFilter` with `ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0)` to create realistic depth and focus.

---

## 3. UI Layout & Form Inputs
The interface layout consists of a focused, single-scrollable view:
- **Header Section**:
  - Descriptive, stylized title: "📅 Date Time Checker" in large bold lettering.
  - Minimal, high-quality subtitle describing the purpose: "Verify calendar date validity instantly with premium feedback."
- **Input Fields Grid**:
  - Formed of a horizontal `Row` containing 3 side-by-side equal-width `TextField` boxes: **Day**, **Month**, and **Year**.
  - **Inputs Configuration**:
    - `keyboardType`: `TextInputType.number` (Ensures numeric keyboard entry for all fields)
    - `textAlign`: `TextAlign.center` for comfortable visual spacing.
    - Focus node chain allows standard keyboard Next transitions: **Day** ➔ **Month** ➔ **Year** ➔ **Check trigger**.
    - Display clear numeric hints (e.g., `Day: 30`, `Month: 5`, `Year: 2026`).
- **Action Buttons Layout**:
  - Arranged side-by-side or stacked logically for comfortable thumb reach.
  - **🧹 Clear Button**: Custom outlined glass action button. When tapped, it empties all input fields, resets validation state, and sets keyboard focus back to the Day field.
  - **✔ Check Validity Button**: A wide, glowing action button featuring an emerald-cyan gradient fill. On tap, it hides the software keyboard and initiates validation.

---

## 4. Business Logic & Validation rules
Validation leverages the existing robust calendar check logic in `lib/date_time_validator.dart`:
1. **Empty Checks**: Prevents checking if fields are left blank.
2. **Type Parsing**: Parses day, month, and year inputs to valid integers.
3. **Range Validation**:
   - Day must be in `1 - 31`.
   - Month must be in `1 - 12` (numeric inputs only).
   - Year must be in `1 - 9999`.
4. **Calendar Constraint Validation**:
   - Month-specific length checks (e.g. November has max 30 days).
   - Accurate Leap Year check for February (Year is leap if divisible by 4, not by 100, unless divisible by 400).
5. **Success Metadata**: On success, outputs the fully formatted date and identifies the specific day of the week (e.g., *falls on a Saturday*).

---

## 5. Result Presentation: Floating Glass Modal
Instead of an inline card, validation results will pop up in a centered modal overlay:
- **Presentation Trigger**: Initiated immediately when the validation completes.
- **Visual Backdrop**: Active `BackdropFilter` with a `sigma` blur of 12.0, tinting the background elements into a beautiful, out-of-focus backdrop.
- **Modal Container**:
  - Floating centered card with standard glassmorphic borders and a deep radial shadow.
  - Custom colored glowing border indicating the check result:
    - **Valid Date**: Emerald green glowing outline, checked shield icon, details showing day of week and leap year notes.
    - **Invalid Date**: Neon crimson glowing outline, alert triangle icon, listing exact error messages and educational context (e.g., explaining February's leap year rules).
  - **Dismissal Button**: Centered translucent glass button labelled "Done" or "Go Back" that pops the navigator or closes the modal safely.

---

## 6. Verification & Testing Plan
- **Manual Verification**:
  - Run the application on a mobile emulator/device.
  - Test validation with leap years:
    - `29/02/2024` ➔ SUCCESS (Leap Year)
    - `29/02/2026` ➔ FAILURE (Non-Leap Year)
  - Verify numeric keyboard pops up on all three input fields.
  - Verify "Clear" correctly clears all fields and resets keyboard focus to "Day".
  - Verify backdrop blur activates, and centered dialog displays neon glows depending on validity outcome.
- **Automated Verification**:
  - Maintain and run unit tests for `DateTimeValidator` to ensure no regression of date parsing rules.
