import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';
import 'package:pharmacy_medication/shared/widgets/app_network_image.dart';
import 'package:pharmacy_medication/shared/widgets/card_3d.dart';
import 'package:pharmacy_medication/features/prescription/presentation/screens/pharmacist_advice_form_screen.dart';

class HealthAdviceArticleScreen extends StatelessWidget {
  final String title;
  final String imageUrl;

  const HealthAdviceArticleScreen({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                title,
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                  shadows: [const Shadow(blurRadius: 10, color: Colors.black)],
                ),
              ),
              background: AppNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 14, color: AppColors.grey),
                      const SizedBox(width: 8),
                      Text(
                        'Last Reviewed: July 2024',
                        style: GoogleFonts.manrope(fontSize: 12, color: AppColors.grey),
                      ),
                      const Spacer(),
                      const Icon(Icons.verified_user, size: 14, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        'Pharmacist Reviewed',
                        style: GoogleFonts.manrope(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildParagraph('Professional health advice from your Kersbrook Pharmacy team. Understanding your health is the first step toward effective management and well-being.'),
                  _buildSectionTitle('Overview'),
                  _buildParagraph('Managing your health requires reliable information and regular consultation with healthcare professionals. This guide provides essential insights into maintaining optimal health within this category.'),
                  _buildSectionTitle('Key Recommendations'),
                  _buildParagraph('• Maintain a balanced diet and regular exercise.\n• Consult your pharmacist before starting new supplements.\n• Keep a record of your medications and symptoms.\n• Schedule regular health check-ups.'),
                  const SizedBox(height: 32),
                  _buildContactCard(context),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textDark),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textLight, height: 1.6),
    );
  }

  Widget _buildContactCard(BuildContext context) {
    return Card3D(
      borderRadius: 20,
      padding: const EdgeInsets.all(24),
      baseColor: AppColors.primaryLight,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.health_and_safety, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Need Personal Advice?',
                style: GoogleFonts.manrope(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Our pharmacists are here to help you with specific questions about your health and medications.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(fontSize: 13, color: AppColors.textDark, height: 1.5),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PharmacistAdviceFormScreen()));
              },
              icon: const Icon(Icons.chat_bubble_outline, size: 18),
              label: const Text('Speak to a Pharmacist'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
