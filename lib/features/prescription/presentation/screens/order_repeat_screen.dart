import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';

class OrderRepeatScreen extends StatefulWidget {
  const OrderRepeatScreen({super.key});

  @override
  State<OrderRepeatScreen> createState() => _OrderRepeatScreenState();
}

class _OrderRepeatScreenState extends State<OrderRepeatScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Order a Repeat')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Repeats Held at Pharmacy',
                style: GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark),
              ),
              const SizedBox(height: 12),
              Text(
                'For prescriptions already held by Kersbrook Pharmacy. Please provide details of the medication you need.',
                style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textLight, height: 1.5),
              ),
              const SizedBox(height: 32),
              _buildTextField('Medication Name & Strength', Icons.medication),
              _buildTextField('Patient Full Name', Icons.person),
              _buildTextField('Phone Number', Icons.phone),
              _buildTextField('Special Instructions / Delivery Notes', Icons.note_add, maxLines: 3),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Repeat Order Submitted')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Submit Repeat Order'),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Orders are subject to pharmacist review. We will notify you when your prescription is ready for collection or delivery.',
                        style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary),
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
}
