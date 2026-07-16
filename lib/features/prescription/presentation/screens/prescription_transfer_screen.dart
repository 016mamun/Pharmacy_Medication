import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';

class PrescriptionTransferScreen extends StatelessWidget {
  const PrescriptionTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Prescription Transfer')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transfer to Kersbrook Pharmacy',
              style: GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark),
            ),
            const SizedBox(height: 12),
            Text(
              'Request assistance transferring eligible prescription records or repeats from another pharmacy.',
              style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textLight, height: 1.5),
            ),
            const SizedBox(height: 32),
            const _TransferForm(),
          ],
        ),
      ),
    );
  }
}

class _TransferForm extends StatefulWidget {
  const _TransferForm();

  @override
  State<_TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends State<_TransferForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField('Patient Full Name', Icons.person),
          _buildTextField('Phone Number', Icons.phone),
          _buildTextField('Current Pharmacy Name', Icons.local_pharmacy),
          _buildTextField('Current Pharmacy Suburb', Icons.location_city),
          _buildTextField('Medication List (Optional)', Icons.medication, maxLines: 3),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Transfer Request Submitted')),
                  );
                }
              },
              child: const Text('Submit Request'),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'A pharmacist will contact you to coordinate the transfer and confirm legal requirements.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(fontSize: 12, color: AppColors.grey),
          ),
        ],
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
