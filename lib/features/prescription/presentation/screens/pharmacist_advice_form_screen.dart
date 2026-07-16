import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';

class PharmacistAdviceFormScreen extends StatefulWidget {
  const PharmacistAdviceFormScreen({super.key});

  @override
  State<PharmacistAdviceFormScreen> createState() => _PharmacistAdviceFormScreenState();
}

class _PharmacistAdviceFormScreenState extends State<PharmacistAdviceFormScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Ask a Pharmacist')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Professional Advice from a Real Pharmacist',
                style: GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark),
              ),
              const SizedBox(height: 12),
              Text(
                'Contact Kersbrook Pharmacy for advice about medicines, interactions, side effects and safe use.',
                style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textLight, height: 1.5),
              ),
              const SizedBox(height: 32),
              _buildTextField('Your Name', Icons.person),
              _buildTextField('Phone Number', Icons.phone),
              _buildTextField('Your Question / Concern', Icons.help_outline, maxLines: 5),
              const SizedBox(height: 24),
              Text(
                'Preferred Callback Method',
                style: GoogleFonts.manrope(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                children: [
                  ChoiceChip(label: const Text('Phone Call'), selected: true, onSelected: (_) {}),
                  ChoiceChip(label: const Text('Email'), selected: false, onSelected: (_) {}),
                  ChoiceChip(label: const Text('Text Message'), selected: false, onSelected: (_) {}),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Enquiry Sent to Pharmacist')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Send Enquiry'),
                ),
              ),
              const SizedBox(height: 24),
              _buildSafetyNotice(),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 20),
          alignLabelWithHint: maxLines > 1,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Required';
          return null;
        },
      ),
    );
  }

  Widget _buildSafetyNotice() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 24),
          const SizedBox(height: 12),
          Text(
            'Important Notice',
            style: GoogleFonts.manrope(fontWeight: FontWeight.w800, color: Colors.brown),
          ),
          const SizedBox(height: 8),
          Text(
            'This service is not monitored continuously and is not suitable for emergencies. For urgent or severe symptoms, call 000 or seek immediate medical care.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(fontSize: 11, color: Colors.brown),
          ),
        ],
      ),
    );
  }
}
