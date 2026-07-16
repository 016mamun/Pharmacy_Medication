import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() => _currentStep++);
          } else {
            _showOrderSuccess();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          }
        },
        steps: [
          Step(
            title: const Text('Delivery'),
            content: Column(
              children: [
                _buildTextField('Full Name'),
                const SizedBox(height: 12),
                _buildTextField('Address'),
                const SizedBox(height: 12),
                _buildTextField('Suburb / Postcode'),
              ],
            ),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text('Pharmacist Review'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pharmacy Medicine Questionnaire',
                  style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.primary),
                ),
                const SizedBox(height: 12),
                Text(
                  'To ensure safe supply, please confirm:',
                  style: GoogleFonts.manrope(fontSize: 14),
                ),
                const SizedBox(height: 16),
                _buildCheckbox('Is this for yourself?'),
                _buildCheckbox('Are you taking other medications?'),
                _buildCheckbox('Do you have any medical conditions?'),
              ],
            ),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: const Text('Payment'),
            content: Column(
              children: [
                Text(
                  'Payment is securely processed via our compliant provider.',
                  style: GoogleFonts.manrope(fontSize: 14),
                ),
                const SizedBox(height: 20),
                _buildTextField('Card Number'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildTextField('Expiry')),
                    const SizedBox(width: 12),
                    Expanded(child: _buildTextField('CVV')),
                  ],
                ),
              ],
            ),
            isActive: _currentStep >= 2,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildCheckbox(String label) {
    return CheckboxListTile(
      title: Text(label, style: GoogleFonts.manrope(fontSize: 13)),
      value: false,
      onChanged: (_) {},
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }

  void _showOrderSuccess() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Order Placed'),
        content: const Text('Thank you! Your order has been placed and is now in our pharmacist review queue.'),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          }, child: const Text('Return to Home')),
        ],
      ),
    );
  }
}
