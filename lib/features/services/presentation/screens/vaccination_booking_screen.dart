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
  String _selectedService = 'General Vaccination';
  String _selectedDate = '';
  String _selectedTime = '';
  bool _eligibilityConfirmed = false;

  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _medicareController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedService = widget.vaccineName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _medicareController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Vaccination Booking')),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text(
                    _currentStep == 4 ? 'Confirm Booking' : 'Continue',
                    style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
                  ),
                ),
                if (_currentStep > 0)
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text('Back'),
                  ),
              ],
            ),
          );
        },
        onStepContinue: () {
          if (_currentStep == 1 && !_eligibilityConfirmed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please confirm your eligibility.')),
            );
            return;
          }
          if (_currentStep == 2 && (_selectedDate.isEmpty || _selectedTime.isEmpty)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please select a date and time.')),
            );
            return;
          }
          if (_currentStep == 3 && (_nameController.text.isEmpty || _phoneController.text.isEmpty)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please provide your name and phone number.')),
            );
            return;
          }
          if (_currentStep < 4) {
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
          // 1. Select Service
          Step(
            title: Text('Select Service', style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
            content: DropdownButtonFormField<String>(
              isExpanded: true,
              value: _selectedService,
              items: ['General Vaccination', 'Influenza (Flu)', 'Whooping Cough (dTpa)', 'Travel Vaccination', 'Other']
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedService = val);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            isActive: _currentStep >= 0,
          ),
          
          // 2. Read Eligibility
          Step(
            title: Text('Read Eligibility', style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Please note that some vaccines have strict age or health-based eligibility criteria. Our pharmacist will assess your suitability before administration. Do not attend if you have a fever or feel unwell.',
                    style: GoogleFonts.manrope(fontSize: 13, height: 1.5, color: AppColors.textDark),
                  ),
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  title: Text('I have read and understood the eligibility criteria.', style: GoogleFonts.manrope(fontSize: 13)),
                  value: _eligibilityConfirmed,
                  onChanged: (val) => setState(() => _eligibilityConfirmed = val ?? false),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColors.primary,
                ),
              ],
            ),
            isActive: _currentStep >= 1,
          ),

          // 3. Choose Appointment
          Step(
            title: Text('Choose Appointment', style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Available Dates:', style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ['Mon, Jul 22', 'Tue, Jul 23', 'Wed, Jul 24'].map((d) => ChoiceChip(
                    label: Text(d),
                    selected: _selectedDate == d,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedDate = d);
                    },
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(color: _selectedDate == d ? Colors.white : AppColors.textDark),
                  )).toList(),
                ),
                const SizedBox(height: 16),
                Text('Available Times:', style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ['09:00 AM', '11:30 AM', '02:00 PM', '04:15 PM'].map((t) => ChoiceChip(
                    label: Text(t),
                    selected: _selectedTime == t,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedTime = t);
                    },
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(color: _selectedTime == t ? Colors.white : AppColors.textDark),
                  )).toList(),
                ),
              ],
            ),
            isActive: _currentStep >= 2,
          ),

          // 4. Provide Info
          Step(
            title: Text('Provide Information', style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
            content: Column(
              children: [
                _buildTextField('Full Name', _nameController, Icons.person),
                const SizedBox(height: 12),
                _buildTextField('Date of Birth', _dobController, Icons.calendar_today),
                const SizedBox(height: 12),
                _buildTextField('Phone Number', _phoneController, Icons.phone),
                const SizedBox(height: 12),
                _buildTextField('Medicare Number (Optional)', _medicareController, Icons.credit_card),
              ],
            ),
            isActive: _currentStep >= 3,
          ),

          // 5. Confirm
          Step(
            title: Text('Review & Confirm', style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
            content: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.inputBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _summaryText('Service', _selectedService),
                  _summaryText('Date', _selectedDate.isEmpty ? 'Not selected' : _selectedDate),
                  _summaryText('Time', _selectedTime.isEmpty ? 'Not selected' : _selectedTime),
                  _summaryText('Patient', _nameController.text.isEmpty ? 'Not provided' : _nameController.text),
                  const Divider(),
                  Text(
                    'Payment for non-funded vaccines is collected in-store on the day of the appointment.',
                    style: GoogleFonts.manrope(fontSize: 12, color: AppColors.textLight, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            isActive: _currentStep >= 4,
          ),
        ],
      ),
    );
  }

  Widget _summaryText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: GoogleFonts.manrope(fontSize: 13, color: AppColors.textLight),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20, color: AppColors.primary),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.inputBorder)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  void _showConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 48),
            const SizedBox(height: 12),
            Text('Booking Confirmed', style: GoogleFonts.manrope(fontWeight: FontWeight.w800)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Preparation Instructions:', style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            _bulletText('Wear a short-sleeved or loose-fitting shirt.'),
            _bulletText('Stay hydrated and eat beforehand.'),
            _bulletText('Do not attend if you feel unwell or have a fever.'),
            const SizedBox(height: 16),
            Text('Next Steps:', style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            _bulletText('A reminder SMS will be sent 24 hours prior.'),
            _bulletText('Please arrive 5 minutes early and attend with a valid ID (and Medicare card if applicable).'),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bulletText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: GoogleFonts.manrope(fontSize: 13, height: 1.4))),
        ],
      ),
    );
  }
}
