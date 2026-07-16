import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';

class WebsterPakReferralScreen extends StatefulWidget {
  const WebsterPakReferralScreen({super.key});

  @override
  State<WebsterPakReferralScreen> createState() => _WebsterPakReferralScreenState();
}

class _WebsterPakReferralScreenState extends State<WebsterPakReferralScreen> {
  final _formKey = GlobalKey<FormState>();
  String _referralSource = 'Family Member';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Webster-pak® Referral')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Refer a Patient for Medication Packing',
                style: GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark),
              ),
              const SizedBox(height: 12),
              Text(
                'Provide details of the person who needs medication packing assistance. We will contact you or the patient to discuss eligibility.',
                style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textLight, height: 1.5),
              ),
              const SizedBox(height: 32),
              Text(
                'I am referring as a:',
                style: GoogleFonts.manrope(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildReferralSourceDropdown(),
              const SizedBox(height: 24),
              _buildSectionTitle('Patient Details'),
              _buildTextField('Patient Full Name', Icons.person),
              _buildTextField('Patient Phone Number', Icons.phone),
              const SizedBox(height: 24),
              _buildSectionTitle('Referrer Details'),
              _buildTextField('Your Full Name', Icons.person_outline),
              _buildTextField('Your Contact Number', Icons.phone_android),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Referral Submitted Successfully')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Submit Referral'),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary),
      ),
    );
  }

  Widget _buildReferralSourceDropdown() {
    final sources = ['Family Member', 'Carer', 'GP / Clinic', 'Support Coordinator', 'Nurse', 'Aged-care Provider'];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _referralSource,
          isExpanded: true,
          items: sources.map((s) => DropdownMenuItem(value: s, child: Text(s, style: GoogleFonts.manrope(fontSize: 14)))).toList(),
          onChanged: (val) => setState(() => _referralSource = val!),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 20),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Required';
          return null;
        },
      ),
    );
  }
}
