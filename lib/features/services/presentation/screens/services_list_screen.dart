import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';
import 'package:pharmacy_medication/shared/widgets/card_3d.dart';
import 'package:pharmacy_medication/features/services/presentation/screens/service_details_screen.dart';

class ServicesListScreen extends StatelessWidget {
  const ServicesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {'title': 'MedsCheck', 'desc': 'Review your medicines with a pharmacist.', 'icon': Icons.checklist_rtl},
      {'title': 'Diabetes Support', 'desc': 'Specialised care and NDSS support.', 'icon': Icons.bloodtype},
      {'title': 'Blood Pressure Monitoring', 'desc': 'Regular checks and recording.', 'icon': Icons.favorite},
      {'title': 'Inhaler Technique', 'desc': 'Ensure you get the most from your medicine.', 'icon': Icons.air},
      {'title': 'Medication Disposal', 'desc': 'Safe return of unwanted medicines.', 'icon': Icons.delete_sweep},
      {'title': 'Weight Management', 'desc': 'Professional advice and support.', 'icon': Icons.monitor_weight},
      {'title': 'Smoking Cessation', 'desc': 'Kick the habit with our support.', 'icon': Icons.smoke_free},
      {'title': 'Carer Medication Support', 'desc': 'Helping you care for your loved ones.', 'icon': Icons.volunteer_activism},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Pharmacy Services'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Card3D(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ServiceDetailsScreen(
                      title: service['title'] as String,
                      description: service['desc'] as String,
                      icon: service['icon'] as IconData,
                    ),
                  ),
                );
              },
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(service['icon'] as IconData, color: AppColors.primary),
                ),
                title: Text(
                  service['title'] as String,
                  style: GoogleFonts.manrope(fontWeight: FontWeight.w800, fontSize: 16),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    service['desc'] as String,
                    style: GoogleFonts.manrope(fontSize: 13, color: AppColors.textLight),
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}
