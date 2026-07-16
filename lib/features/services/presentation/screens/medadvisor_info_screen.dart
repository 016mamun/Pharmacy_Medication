import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';

class MedAdvisorInfoScreen extends StatelessWidget {
  const MedAdvisorInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('MedAdvisor')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: const Color(0xFFF0F7FF),
              child: Column(
                children: [
                  const Icon(Icons.app_shortcut, size: 60, color: Colors.blue),
                  const SizedBox(height: 16),
                  Text(
                    'Manage your medicines with MedAdvisor',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.w800, color: const Color(0xFF004080)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stay connected to Kersbrook Pharmacy and manage your health from your smartphone.',
                    style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textLight, height: 1.5),
                  ),
                  const SizedBox(height: 32),
                  _buildBenefitItem('Order prescriptions and repeats', Icons.receipt_long),
                  _buildBenefitItem('View repeats held by the pharmacy', Icons.history),
                  _buildBenefitItem('Receive automatic medicine reminders', Icons.notifications_active),
                  _buildBenefitItem('Select collection or available delivery', Icons.local_shipping),
                  _buildBenefitItem('Manage medicines for family members', Icons.people),
                  _buildBenefitItem('Message our pharmacy team directly', Icons.chat),
                  const SizedBox(height: 40),
                  Text(
                    'Download the App',
                    style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _AppStoreButton(
                          label: 'App Store',
                          icon: Icons.apple,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _AppStoreButton(
                          label: 'Google Play',
                          icon: Icons.android,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Login via Browser'),
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

  Widget _buildBenefitItem(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppStoreButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _AppStoreButton({required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
