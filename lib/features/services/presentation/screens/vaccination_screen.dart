import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';
import 'package:pharmacy_medication/features/home/providers/home_provider.dart';

import 'package:pharmacy_medication/features/services/presentation/screens/vaccination_booking_screen.dart';

class VaccinationScreen extends ConsumerWidget {
  const VaccinationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Vaccination Bookings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              ref.read(bottomNavIndexProvider.notifier).state = 0;
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: AppColors.secondary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pharmacist Vaccination Appointments',
                    style: GoogleFonts.manrope(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Local care for you and your family',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
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
                    'Available Vaccinations',
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildVaccineItem(
                    'Influenza (Flu)',
                    'Seasonal protection for adults and children.',
                    'From \$25.00',
                  ),
                  _buildVaccineItem(
                    'Whooping Cough (dTpa)',
                    'Essential for carers and expectant parents.',
                    'From \$45.00',
                  ),
                  _buildVaccineItem(
                    'Shingles',
                    'Recommended for older adults.',
                    'Eligibility applies',
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Your Booking Journey'),
                  _stepItem('1', 'Select Service'),
                  _stepItem('2', 'Read Eligibility'),
                  _stepItem('3', 'Choose Appointment'),
                  _stepItem('4', 'Provide Information'),
                  _stepItem('5', 'Confirm Booking'),
                  _stepItem('6', 'Review Prep Instructions'),
                  _stepItem('7', 'Receive Reminder SMS'),
                  _stepItem('8', 'Attend with Valid ID'),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const VaccinationBookingScreen(vaccineName: 'General Vaccination')));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Start Booking Now'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Please note: We do not promote specific vaccine brands. Brand availability is subject to stock and pharmacist clinical assessment on the day of your appointment.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(fontSize: 11, color: AppColors.textLight, fontStyle: FontStyle.italic),
                  ),
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

  Widget _buildVaccineItem(String name, String description, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.manrope(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.manrope(fontSize: 12, color: AppColors.textLight),
                ),
              ],
            ),
          ),
          Text(
            price,
            style: GoogleFonts.manrope(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Text(text, style: GoogleFonts.manrope(fontSize: 14)),
        ],
      ),
    );
  }
}
