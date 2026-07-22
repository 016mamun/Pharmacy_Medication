import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textDark, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(
              "Create Account",
              style: GoogleFonts.manrope(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 32),
            
            _buildInputLabel("Full Name"),
            _buildTextField("Your full name", Icons.person_outline),
            
            const SizedBox(height: 16),
            _buildInputLabel("Email address"),
            _buildTextField("Your email address", Icons.person_outline),
            
            const SizedBox(height: 16),
            _buildInputLabel("Password"),
            _buildTextField("Password", Icons.lock_outline, isPassword: true),
            
            const SizedBox(height: 16),
            _buildInputLabel("confirm password"),
            _buildTextField("Confirm password", Icons.lock_outline, isPassword: true),
            
            const SizedBox(height: 16),
            _buildInputLabel("Id"),
            _buildTextField("Identification number", Icons.badge_outlined),
            
            const SizedBox(height: 24),
            Text.rich(
              TextSpan(
                text: "By creating an account, you agree to our ",
                style: GoogleFonts.manrope(fontSize: 12, color: AppColors.textLight),
                children: [
                  TextSpan(
                    text: "Terms of Service",
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy",
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                  ),
                  const TextSpan(text: "."),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: Text(
                  "Sign up",
                  style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon, {bool isPassword = false}) {
    return TextFormField(
      obscureText: isPassword,
      style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textDark, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.manrope(fontSize: 14, color: AppColors.grey, fontWeight: FontWeight.w400),
        prefixIcon: Icon(icon, color: AppColors.primary.withValues(alpha: 0.6), size: 20),
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE9ECEF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE9ECEF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
