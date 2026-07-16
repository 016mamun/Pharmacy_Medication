import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';

class VaccinationBookingScreen extends StatefulWidget {
  final String vaccineName;
  const VaccinationBookingScreen({super.key, required this.vaccineName});

  @override
  State<VaccinationBookingScreen> createState() => _VaccinationBookingScreenState();
}

class _VaccinationBookingScreenState extends State<VaccinationBookingScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Vaccination Booking')),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() => _currentStep++);
          } else {
            _showConfirmation();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          }
        },
        steps: [
          Step(
            title: Text('Select Service', style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
            content: Text('You are booking for: ${widget.vaccineName}', style: GoogleFonts.manrope(color: AppColors.primary, fontWeight: FontWeight.w600)),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: Text('Patient Information', style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
            content: Column(
              children: [
                _buildTextField('Full Name'),
                const SizedBox(height: 12),
                _buildTextField('Date of Birth'),
                const SizedBox(height: 12),
                _buildTextField('Medicare Number (Optional)'),
              ],
            ),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: Text('Appointment Time', style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Available Dates:', style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: ['Mon, Jul 22', 'Tue, Jul 23', 'Wed, Jul 24'].map((d) => ChoiceChip(label: Text(d), selected: false)).toList(),
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

  void _showConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Booking Confirmed'),
        content: const Text('Your vaccination appointment has been booked. You will receive a confirmation SMS shortly.'),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          }, child: const Text('Return to Services')),
        ],
      ),
    );
  }
}
