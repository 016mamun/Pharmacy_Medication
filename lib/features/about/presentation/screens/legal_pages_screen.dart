import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';

class LegalPagesScreen extends StatelessWidget {
  const LegalPagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final policies = [
      'Privacy Policy',
      'Website Terms of Use',
      'Online Store Terms and Conditions',
      'Shipping and Delivery Policy',
      'Returns and Refunds Policy',
      'Prescription Supply Terms',
      'Complaints and Feedback',
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Legal & Policies'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: policies.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              policies[index],
              style: GoogleFonts.manrope(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.grey),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening ${policies[index]}...')),
              );
            },
          );
        },
      ),
    );
  }
}
