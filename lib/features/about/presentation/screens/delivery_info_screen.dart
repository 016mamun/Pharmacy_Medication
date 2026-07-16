import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';

class DeliveryInfoScreen extends StatelessWidget {
  const DeliveryInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Delivery Information'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Prescription & Shop Delivery',
                style: GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark),
              ),
              const SizedBox(height: 12),
              Text(
                'Kersbrook Pharmacy provides local Adelaide Hills delivery and nationwide Australia-wide shipping for eligible products.',
                style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textLight, height: 1.5),
              ),
              const SizedBox(height: 32),
              _deliverySection(
                'Local Delivery (Adelaide Hills)',
                'Zone 1: Kersbrook and surrounding local areas.\n• Scheduled delivery times.\n• Local collection (Click & Collect) available.',
                Icons.local_shipping,
              ),
              const SizedBox(height: 24),
              _deliverySection(
                'Nationwide Delivery',
                'Zone 2-5: Australia-wide shipping via tracked courier.\n• Standard tracked delivery.\n• Express options for non-restricted items.',
                Icons.public,
              ),
              const SizedBox(height: 24),
              _deliverySection(
                'Prescription Delivery',
                'Strict regulations apply to prescription delivery.\n• Pharmacist review required.\n• ID verification upon delivery.\n• Signature required.',
                Icons.medication,
              ),
              const SizedBox(height: 24),
              _deliverySection(
                'Cold-Chain Products',
                'Insulated packaging for temperature-sensitive items.\n• Exclusions may apply for certain remote locations.\n• In-person collection recommended where possible.',
                Icons.ac_unit,
              ),
              const SizedBox(height: 40),
              _buildImportantNotice(),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _deliverySection(String title, String content, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 34),
          child: Text(
            content,
            style: GoogleFonts.manrope(fontSize: 13, color: AppColors.textLight, height: 1.6),
          ),
        ),
      ],
    );
  }

  Widget _buildImportantNotice() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          const Icon(Icons.info_outline, color: Colors.blue, size: 24),
          const SizedBox(height: 12),
          Text(
            'Urgent Medications',
            style: GoogleFonts.manrope(fontWeight: FontWeight.w800, color: const Color(0xFF004080)),
          ),
          const SizedBox(height: 8),
          Text(
            'Patients requiring urgent supply of medicines should not rely on postal delivery. Please contact the pharmacy team directly to discuss options.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(fontSize: 12, color: const Color(0xFF004080)),
          ),
        ],
      ),
    );
  }
}
