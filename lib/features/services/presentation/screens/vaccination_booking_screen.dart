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

  final List<Map<String, dynamic>> _services = [
    {'name': 'General Vaccination', 'icon': Icons.vaccines, 'color': Color(0xFF1565C0)},
    {'name': 'Influenza (Flu)', 'icon': Icons.air, 'color': Color(0xFF00838F)},
    {'name': 'Whooping Cough (dTpa)', 'icon': Icons.child_care, 'color': Color(0xFF6A1B9A)},
    {'name': 'Travel Vaccination', 'icon': Icons.flight, 'color': Color(0xFFE65100)},
    {'name': 'COVID-19 Booster', 'icon': Icons.coronavirus, 'color': Color(0xFFC62828)},
    {'name': 'Other', 'icon': Icons.medical_services, 'color': Color(0xFF2E7D32)},
  ];

  final List<String> _dates = ['Mon, Jul 22', 'Tue, Jul 23', 'Wed, Jul 24', 'Thu, Jul 25', 'Fri, Jul 26'];
  final List<String> _times = ['09:00 AM', '10:30 AM', '11:30 AM', '01:00 PM', '02:30 PM', '04:00 PM'];

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

  List<Map<String, dynamic>> get _steps => [
    {'label': 'Service', 'icon': Icons.vaccines},
    {'label': 'Eligibility', 'icon': Icons.fact_check_outlined},
    {'label': 'Appointment', 'icon': Icons.calendar_month},
    {'label': 'Your Info', 'icon': Icons.person_outline},
    {'label': 'Confirm', 'icon': Icons.check_circle_outline},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text(
          'Vaccination Booking',
          style: GoogleFonts.manrope(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress header
          _buildProgressHeader(),
          // Step content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildStepContent(),
                    const SizedBox(height: 20),
                    _buildStepControls(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressHeader() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        children: [
          // Step indicators
          Row(
            children: List.generate(_steps.length * 2 - 1, (i) {
              if (i.isOdd) {
                // Connector line
                final stepIndex = i ~/ 2;
                final isDone = _currentStep > stepIndex;
                return Expanded(
                  child: Container(
                    height: 2,
                    color: isDone
                        ? Colors.white.withValues(alpha: 0.8)
                        : Colors.white.withValues(alpha: 0.2),
                  ),
                );
              }
              final stepIndex = i ~/ 2;
              final isDone = _currentStep > stepIndex;
              final isCurrent = _currentStep == stepIndex;
              return Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isDone
                          ? Colors.white
                          : isCurrent
                              ? Colors.white.withValues(alpha: 0.25)
                              : Colors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isCurrent || isDone
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      isDone ? Icons.check : _steps[stepIndex]['icon'],
                      size: 16,
                      color: isDone ? AppColors.primary : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _steps[stepIndex]['label'],
                    style: GoogleFonts.manrope(
                      fontSize: 9,
                      fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                      color: isCurrent ? Colors.white : Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildServiceStep();
      case 1:
        return _buildEligibilityStep();
      case 2:
        return _buildAppointmentStep();
      case 3:
        return _buildInfoStep();
      case 4:
        return _buildReviewStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildServiceStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(Icons.vaccines, 'Select Vaccination Service'),
        const SizedBox(height: 4),
        Text(
          'Choose the vaccine you would like to book.',
          style: GoogleFonts.manrope(fontSize: 13, color: AppColors.textLight),
        ),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: _services.map((service) {
            final isSelected = _selectedService == service['name'];
            return GestureDetector(
              onTap: () => setState(() => _selectedService = service['name']),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected ? (service['color'] as Color).withValues(alpha: 0.12) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? service['color'] as Color : AppColors.inputBorder,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: isSelected
                      ? [BoxShadow(color: (service['color'] as Color).withValues(alpha: 0.15), blurRadius: 12, offset: const Offset(0, 4))]
                      : [const BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(service['icon'] as IconData, color: service['color'] as Color, size: 26),
                    const SizedBox(height: 8),
                    Text(
                      service['name'],
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        fontSize: 11,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                        color: isSelected ? service['color'] as Color : AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildEligibilityStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(Icons.fact_check_outlined, 'Read Eligibility'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryLight, AppColors.primaryLight.withValues(alpha: 0.5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text('Important Information', style: GoogleFonts.manrope(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.primary)),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Please note that some vaccines have strict age or health-based eligibility criteria. Our pharmacist will assess your suitability before administration. Do not attend if you have a fever or feel unwell.',
                style: GoogleFonts.manrope(fontSize: 13, height: 1.6, color: AppColors.textDark),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildEligibilityItem(Icons.thermostat, 'No fever or illness on the day'),
        _buildEligibilityItem(Icons.history, 'No vaccine in the past 2 weeks (for most vaccines)'),
        _buildEligibilityItem(Icons.pregnant_woman, 'Pregnancy: consult your doctor first'),
        _buildEligibilityItem(Icons.no_meals, 'No fasting required — eat and stay hydrated'),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _eligibilityConfirmed ? AppColors.primary : AppColors.inputBorder,
              width: _eligibilityConfirmed ? 1.5 : 1,
            ),
          ),
          child: CheckboxListTile(
            title: Text(
              'I have read and understood the eligibility criteria.',
              style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            value: _eligibilityConfirmed,
            onChanged: (val) => setState(() => _eligibilityConfirmed = val ?? false),
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: AppColors.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
      ],
    );
  }

  Widget _buildEligibilityItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: GoogleFonts.manrope(fontSize: 13, color: AppColors.textDark)),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(Icons.calendar_month, 'Choose Appointment'),
        const SizedBox(height: 20),
        Text('Select a Date', style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _dates.map((d) {
            final isSelected = _selectedDate == d;
            return GestureDetector(
              onTap: () => setState(() => _selectedDate = d),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? AppColors.primary : AppColors.inputBorder),
                  boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4))] : [],
                ),
                child: Text(
                  d,
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : AppColors.textDark,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        Text('Select a Time', style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _times.map((t) {
            final isSelected = _selectedTime == t;
            return GestureDetector(
              onTap: () => setState(() => _selectedTime = t),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? AppColors.primary : AppColors.inputBorder),
                  boxShadow: isSelected ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4))] : [],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.access_time, size: 14, color: isSelected ? Colors.white : AppColors.grey),
                    const SizedBox(width: 6),
                    Text(
                      t,
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(Icons.person_outline, 'Your Information'),
        const SizedBox(height: 8),
        Text('This helps us prepare your appointment.', style: GoogleFonts.manrope(fontSize: 13, color: AppColors.textLight)),
        const SizedBox(height: 20),
        _buildTextField('Full Name', _nameController, Icons.person),
        const SizedBox(height: 14),
        _buildTextField('Date of Birth', _dobController, Icons.calendar_today),
        const SizedBox(height: 14),
        _buildTextField('Phone Number', _phoneController, Icons.phone),
        const SizedBox(height: 14),
        _buildTextField('Medicare Number (Optional)', _medicareController, Icons.credit_card),
      ],
    );
  }

  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader(Icons.check_circle_outline, 'Review & Confirm'),
        const SizedBox(height: 8),
        Text('Please review your booking details before confirming.', style: GoogleFonts.manrope(fontSize: 13, color: AppColors.textLight)),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: Column(
            children: [
              _reviewTile(Icons.vaccines, 'Service', _selectedService, AppColors.primary),
              const Divider(height: 1, indent: 20, endIndent: 20),
              _reviewTile(Icons.calendar_today, 'Date', _selectedDate.isEmpty ? 'Not selected' : _selectedDate, Colors.orange),
              const Divider(height: 1, indent: 20, endIndent: 20),
              _reviewTile(Icons.access_time, 'Time', _selectedTime.isEmpty ? 'Not selected' : _selectedTime, Colors.teal),
              const Divider(height: 1, indent: 20, endIndent: 20),
              _reviewTile(Icons.person, 'Patient', _nameController.text.isEmpty ? 'Not provided' : _nameController.text, Colors.purple),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: Colors.amber.shade700, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Payment for non-funded vaccines is collected in-store on the day of the appointment.',
                  style: GoogleFonts.manrope(fontSize: 12, color: Colors.brown, height: 1.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _reviewTile(IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: GoogleFonts.manrope(fontSize: 11, color: AppColors.textLight)),
              const SizedBox(height: 2),
              Text(value, style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepControls() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _handleContinue,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
              textStyle: GoogleFonts.manrope(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_currentStep == 4 ? 'Confirm Booking' : 'Continue'),
                const SizedBox(width: 8),
                Icon(_currentStep == 4 ? Icons.check_circle_outline : Icons.arrow_forward, size: 18),
              ],
            ),
          ),
        ),
        if (_currentStep > 0) ...[
          const SizedBox(height: 10),
          TextButton.icon(
            onPressed: () => setState(() => _currentStep--),
            icon: const Icon(Icons.arrow_back, size: 16),
            label: const Text('Back'),
            style: TextButton.styleFrom(foregroundColor: AppColors.textLight),
          ),
        ],
      ],
    );
  }

  void _handleContinue() {
    if (_currentStep == 1 && !_eligibilityConfirmed) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please confirm your eligibility.')));
      return;
    }
    if (_currentStep == 2 && (_selectedDate.isEmpty || _selectedTime.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a date and time.')));
      return;
    }
    if (_currentStep == 3 && (_nameController.text.isEmpty || _phoneController.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please provide your name and phone number.')));
      return;
    }
    if (_currentStep < 4) {
      setState(() => _currentStep++);
    } else {
      _showConfirmation();
    }
  }

  Widget _sectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(width: 12),
        Text(title, style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textDark)),
      ],
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
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.inputBorder)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  void _showConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(28),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle),
              child: const Icon(Icons.check_circle_rounded, color: Colors.green, size: 44),
            ),
            const SizedBox(height: 16),
            Text('Booking Confirmed!', style: GoogleFonts.manrope(fontWeight: FontWeight.w900, fontSize: 20, color: AppColors.textDark)),
            const SizedBox(height: 8),
            Text(
              '${_selectedService} on $_selectedDate at $_selectedTime',
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(fontSize: 13, color: AppColors.textLight, height: 1.5),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(14)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Preparation Reminders', style: GoogleFonts.manrope(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.primary)),
                  const SizedBox(height: 10),
                  _reminderItem(Icons.accessibility_new, 'Wear a short-sleeved or loose shirt'),
                  _reminderItem(Icons.local_drink, 'Eat and stay well hydrated'),
                  _reminderItem(Icons.sick, 'Do not attend if you feel unwell'),
                  _reminderItem(Icons.sms, 'Reminder SMS sent 24h prior'),
                  _reminderItem(Icons.badge, 'Bring valid ID & Medicare card'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text('Done', style: GoogleFonts.manrope(fontWeight: FontWeight.w700, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _reminderItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: GoogleFonts.manrope(fontSize: 12, color: AppColors.textDark))),
        ],
      ),
    );
  }
}
