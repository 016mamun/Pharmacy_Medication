import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';

class EScriptSubmissionScreen extends StatefulWidget {
  const EScriptSubmissionScreen({super.key});

  @override
  State<EScriptSubmissionScreen> createState() => _EScriptSubmissionScreenState();
}

class _EScriptSubmissionScreenState extends State<EScriptSubmissionScreen> {
  final _formKey = GlobalKey<FormState>();
  String _collectionMethod = 'Delivery';
  bool _consentRecorded = false;
  bool _identityCheckAcknowledged = false;
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Submit eScript')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Submit your Electronic Prescription',
                style: GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark),
              ),
              const SizedBox(height: 12),
              Text(
                'Please enter your eScript token or upload the QR code received from your doctor.',
                style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textLight, height: 1.5),
              ),
              const SizedBox(height: 32),
              _buildTextField('eScript Token (Alpha-numeric code)', Icons.qr_code),
              const SizedBox(height: 16),
              _buildFileUploadButton(),
              const SizedBox(height: 24),
              Text(
                'Collection or Delivery?',
                style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _radioOption('Delivery'),
                  const SizedBox(width: 20),
                  _radioOption('In-person Collection'),
                ],
              ),
              if (_collectionMethod == 'Delivery') ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    'Restricted Medicine Controls: Interstate delivery may be disabled based on state laws. PO Boxes and Parcel Lockers are strictly prohibited for prescription deliveries. Unattended delivery (Authority to Leave) is not permitted.',
                    style: GoogleFonts.manrope(fontSize: 12, color: Colors.brown, height: 1.4),
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField('Delivery Address (No PO Boxes)', Icons.home, controller: _addressController),
              ],
              const SizedBox(height: 24),
              _buildTextField('Full Name (as per Medicare)', Icons.person),
              _buildTextField('Phone Number', Icons.phone),
              _buildTextField('Email Address', Icons.email),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: Text('I consent to Kersbrook Pharmacy accessing my prescription record and verifying my identity.', style: GoogleFonts.manrope(fontSize: 12)),
                value: _consentRecorded,
                onChanged: (val) => setState(() => _consentRecorded = val ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                activeColor: AppColors.primary,
              ),
              CheckboxListTile(
                title: Text('I understand photo ID may be required upon collection or delivery.', style: GoogleFonts.manrope(fontSize: 12)),
                value: _identityCheckAcknowledged,
                onChanged: (val) => setState(() => _identityCheckAcknowledged = val ?? false),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                activeColor: AppColors.primary,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (!_consentRecorded || !_identityCheckAcknowledged) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please provide required consents.')));
                        return;
                      }
                      if (_collectionMethod == 'Delivery' && _addressController.text.toLowerCase().contains('po box')) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PO Boxes are not allowed for prescriptions.')));
                        return;
                      }
                      _showSuccessDialog();
                    }
                  },
                  child: const Text('Submit for Pharmacist Review'),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Note: Automated checkout is disabled for prescriptions. A pharmacist will review clinical appropriateness, stock, and legal validity before confirming price and arranging payment.',
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(fontSize: 11, color: AppColors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, {TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
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

  Widget _buildFileUploadButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), style: BorderStyle.solid),
        ),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.cloud_upload_outlined, color: AppColors.primary, size: 32),
              const SizedBox(height: 8),
              Text('Upload eScript Image/PDF', style: GoogleFonts.manrope(fontSize: 13, color: AppColors.primary, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _radioOption(String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: _collectionMethod,
          activeColor: AppColors.primary,
          onChanged: (val) => setState(() => _collectionMethod = val!),
        ),
        Text(value, style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600)),
      ],
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Submission Received', style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            Text(
              'Your eScript has been securely sent to Kersbrook Pharmacy. A pharmacist will contact you shortly.',
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }
}
