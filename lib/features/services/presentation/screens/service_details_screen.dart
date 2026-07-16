import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const ServiceDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: AppColors.primary, size: 40),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: GoogleFonts.manrope(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textDark),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textLight, height: 1.6),
            ),
            const SizedBox(height: 32),
            Text(
              'How to access this service',
              style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textDark),
            ),
            const SizedBox(height: 12),
            Text(
              'Visit us in Kersbrook or contact our pharmacists to discuss how we can support your health needs with this service. Appointments may be required for certain clinical reviews.',
              style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textLight, height: 1.6),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Link to Contact Screen (index 3 in MainScreen)
                  // But we are in a sub-navigation context, so maybe just pop or push contact.
                  Navigator.pop(context);
                },
                child: const Text('Contact Us for Details'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
