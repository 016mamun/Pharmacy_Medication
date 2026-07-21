import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';
import 'package:pharmacy_medication/features/home/providers/home_provider.dart';

class ContactScreen extends ConsumerWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.primary, // Using App Primary Color as background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              ref.read(bottomNavIndexProvider.notifier).state = 0;
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We're here to help",
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                "Enquire Online",
                style: GoogleFonts.kaushanScript(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFC5E1A5), // Light green highlight
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Complete the form and our team will be in touch with you shortly.",
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
              const SizedBox(height: 32),
              const _EnquiryForm(),
              const SizedBox(height: 40),
              
              // Footer Section
              const Divider(color: Colors.white24),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.phone_outlined, color: Colors.white, size: 22),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Prefer to talk?",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "08 8389 1205",
                        style: GoogleFonts.manrope(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.email_outlined, color: Colors.white, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "kersbrook@pharmacistadvice.com.au",
                      style: GoogleFonts.manrope(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 120), // Bottom navigation space
            ],
          ),
        ),
      ),
    );
  }
}

class _EnquiryForm extends StatefulWidget {
  const _EnquiryForm();

  @override
  State<_EnquiryForm> createState() => _EnquiryFormState();
}

class _EnquiryFormState extends State<_EnquiryForm> {
  String? _selectedType;
  final List<String> _enquiryTypes = [
    'General Enquiry',
    'Prescription Enquiry',
    'Delivery Enquiry',
    'Webster-pak Enquiry',
    'Vaccination Enquiry',
    'Feedback & Complaints',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Full Name"),
        _buildTextField("Your full name"),
        
        _buildLabel("Phone Number"),
        _buildTextField("Your phone number", keyboardType: TextInputType.phone),
        
        _buildLabel("Email Address"),
        _buildTextField("Your email address", keyboardType: TextInputType.emailAddress),
        
        _buildLabel("I am enquiring about"),
        _buildDropdown(),
        
        _buildLabel("Message (optional)"),
        _buildTextField("How can we help you?", maxLines: 4),
        
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Thank you! Your enquiry has been sent.')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF43A047), // Brighter green for button
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Submit Enquiry',
              style: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
      child: RichText(
        text: TextSpan(
          text: text,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          children: const [
            TextSpan(
              text: " *",
              style: TextStyle(color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1, TextInputType? keyboardType}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textDark),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.manrope(fontSize: 14, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        initialValue: _selectedType,
        hint: Text(
          'Please select',
          style: GoogleFonts.manrope(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        ),
        items: _enquiryTypes.map((String type) {
          return DropdownMenuItem<String>(
            value: type,
            child: Text(
              type,
              style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textDark),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedType = newValue;
          });
        },
        icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textDark),
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
