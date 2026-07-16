import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';
import 'package:pharmacy_medication/shared/widgets/app_network_image.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('About Us'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppNetworkImage(
              imageUrl: 'https://images.pexels.com/photos/5910953/pexels-photo-5910953.jpeg?auto=compress&cs=tinysrgb&w=800',
              height: 200,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Local Kersbrook Pharmacy',
                    style: GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Kersbrook Pharmacy provides trusted community-pharmacy care from the Adelaide Hills, with convenient online services available to patients locally and across Australia.',
                    style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textLight, height: 1.6),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Our Mission'),
                  Text(
                    'To combine personal community-pharmacy care with convenient online services, prioritizing pharmacist access and patient safety.',
                    style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textLight, height: 1.6),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Pharmacist Advice'),
                  Text(
                    'We are proud to be part of the Pharmacist Advice group, delivering professional care and trusted advice.',
                    style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textLight, height: 1.6),
                  ),
                  const SizedBox(height: 32),
                  _buildSectionTitle('Meet the Team'),
                  const SizedBox(height: 12),
                  _buildTeamMember('Lead Pharmacist', 'Professional Care Specialist'),
                  _buildTeamMember('Health Consultant', 'Diabetes & Medication Support'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primary),
      ),
    );
  }

  Widget _buildTeamMember(String name, String role) {
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
          const CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primaryLight,
            child: Icon(Icons.person, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 15)),
              Text(role, style: GoogleFonts.manrope(fontSize: 12, color: AppColors.textLight)),
            ],
          ),
        ],
      ),
    );
  }
}
