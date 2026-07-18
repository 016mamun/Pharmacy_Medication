import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';

import 'package:pharmacy_medication/features/services/presentation/screens/webster_pak_referral_screen.dart';

class WebsterPakScreen extends StatelessWidget {
  const WebsterPakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Webster-pak® Service')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: AppColors.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Free Webster-pak® packing with delivery options across Australia',
                    style: GoogleFonts.manrope(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'We waive the packing fee. You only pay for the cost of your medicines and delivery.',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Make managing multiple medicines easy',
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Our pharmacists professionally organise your suitable tablets and capsules into clearly labelled medication packs by day and administration time.',
                    style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textLight, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Service Benefits'),
                  _benefitItem('Organised by day and time'),
                  _benefitItem('Reduced risk of missed doses'),
                  _benefitItem('Easy for carers and families'),
                  _benefitItem('Nationwide delivery available'),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Register for the Service'),
                  const SizedBox(height: 16),
                  const _WebsterPakForm(),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Referring for someone else?'),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const WebsterPakReferralScreen()));
                      },
                      child: const Text('Refer a Patient'),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary),
      ),
    );
  }

  Widget _benefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.successGreen, size: 20),
          const SizedBox(width: 12),
          Text(text, style: GoogleFonts.manrope(fontSize: 14)),
        ],
      ),
    );
  }
}

class _WebsterPakForm extends StatefulWidget {
  const _WebsterPakForm();

  @override
  State<_WebsterPakForm> createState() => _WebsterPakFormState();
}

class _WebsterPakFormState extends State<_WebsterPakForm> {
  final _formKey = GlobalKey<FormState>();
  String _deliveryFrequency = 'Weekly';
  bool _consentGiven = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField('Full Name', Icons.person),
          _buildTextField('Date of Birth', Icons.calendar_today),
          _buildTextField('Address', Icons.home),
          _buildTextField('Phone Number', Icons.phone),
          _buildTextField('Email Address', Icons.email),
          _buildTextField('Medicare Number (Secure)', Icons.credit_card),
          _buildTextField('Concession / DVA Status (Optional)', Icons.card_membership),
          _buildTextField('Number of Regular Medicines', Icons.medication),
          _buildTextField('Current Pharmacy', Icons.local_pharmacy),
          _buildTextField('Prescriber / Doctor Name', Icons.local_hospital),
          _buildTextField('Carer Details (Name & Phone, if applicable)', Icons.people, required: false),
          const SizedBox(height: 12),
          Text(
            'Delivery Frequency',
            style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textDark),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _deliveryFrequency,
            items: ['Weekly', 'Fortnightly', 'Monthly']
                .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                .toList(),
            onChanged: (val) {
              if (val != null) setState(() => _deliveryFrequency = val);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            title: Text(
              'I consent to Kersbrook Pharmacy accessing my prescriptions and managing my medication packing.',
              style: GoogleFonts.manrope(fontSize: 12, height: 1.4),
            ),
            value: _consentGiven,
            onChanged: (val) => setState(() => _consentGiven = val ?? false),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            activeColor: AppColors.primary,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (!_consentGiven) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please provide your consent to continue.')),
                    );
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registration Request Sent')),
                  );
                }
              },
              child: const Text('Submit Registration'),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Sensitive health data (including Medicare details) is collected via a secure, encrypted process in compliance with Australian privacy laws.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(fontSize: 11, color: AppColors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, {bool required = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 20),
        ),
        validator: required
            ? (value) {
                if (value == null || value.trim().isEmpty) return 'Required';
                return null;
              }
            : null,
      ),
    );
  }
}
