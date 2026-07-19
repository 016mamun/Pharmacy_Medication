import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';
import 'package:pharmacy_medication/features/home/providers/home_provider.dart';

import 'package:pharmacy_medication/features/prescription/presentation/screens/prescription_transfer_screen.dart';
import 'package:pharmacy_medication/features/services/presentation/screens/medadvisor_info_screen.dart';
import 'package:pharmacy_medication/features/prescription/presentation/screens/prescription_guide_screen.dart';
import 'package:pharmacy_medication/features/prescription/presentation/screens/escript_submission_screen.dart';
import 'package:pharmacy_medication/features/prescription/presentation/screens/order_repeat_screen.dart';
import 'package:pharmacy_medication/features/prescription/presentation/screens/pharmacist_advice_form_screen.dart';

class PrescriptionScreen extends ConsumerWidget {
  const PrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Prescription Hub'),
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order prescriptions with\nKersbrook Pharmacy',
                style: GoogleFonts.manrope(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Select your prescription type below to start your order.',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(height: 24),

              _PrescriptionOption(
                title: 'Use MedAdvisor',
                description: 'For patients connected to Kersbrook Pharmacy who want to order prescriptions, repeats and eligible pharmacy items.',
                icon: Icons.app_shortcut,
                color: Colors.blue.shade50,
                iconColor: Colors.blue,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const MedAdvisorInfoScreen()));
                },
              ),
              const SizedBox(height: 16),
              _PrescriptionOption(
                title: 'Send an electronic prescription',
                description: 'Submit an eligible eScript token using our secure workflow.',
                icon: Icons.qr_code_scanner,
                color: Colors.green.shade50,
                iconColor: Colors.green,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const EScriptSubmissionScreen()));
                },
              ),
              const SizedBox(height: 16),
              _PrescriptionOption(
                title: 'Order a repeat',
                description: 'For prescriptions already held by Kersbrook Pharmacy.',
                icon: Icons.replay,
                color: Colors.orange.shade50,
                iconColor: Colors.orange,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderRepeatScreen()));
                },
              ),
              const SizedBox(height: 16),
              _PrescriptionOption(
                title: 'Transfer to Kersbrook Pharmacy',
                description: 'Request assistance transferring eligible prescription records or repeats.',
                icon: Icons.swap_horiz,
                color: Colors.purple.shade50,
                iconColor: Colors.purple,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PrescriptionTransferScreen()));
                },
              ),
              const SizedBox(height: 16),
              _PrescriptionOption(
                title: 'Speak to a pharmacist',
                description: 'For delivery suitability, urgent supply questions or medicine-related advice.',
                icon: Icons.chat_bubble_outline,
                color: Colors.teal.shade50,
                iconColor: Colors.teal,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PharmacistAdviceFormScreen()));
                },
              ),

              const SizedBox(height: 32),
              Text(
                'Information Guides',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 16),
              _GuideLink(
                title: 'How eScripts work',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrescriptionGuideScreen(
                  title: 'How eScripts work',
                  content: 'Electronic prescriptions (eScripts) are a digital alternative to paper prescriptions. Your doctor sends a token (QR code) to your phone via SMS or email, which you can then securely share with Kersbrook Pharmacy.',
                ))),
              ),
              _GuideLink(
                title: 'Managing repeat prescriptions',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrescriptionGuideScreen(
                  title: 'Managing repeat prescriptions',
                  content: 'If your medicine has repeats, Kersbrook Pharmacy can securely hold them for you. This makes ordering your next supply faster and easier through MedAdvisor or our secure ordering system.',
                ))),
              ),
              _GuideLink(
                title: 'PBS and Private prescriptions',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrescriptionGuideScreen(
                  title: 'PBS and Private prescriptions',
                  content: 'The Pharmaceutical Benefits Scheme (PBS) provides subsidised medicines to Australian residents. We process both PBS and private prescriptions, ensuring you receive the correct benefit based on your eligibility.',
                ))),
              ),

              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline, color: Colors.amber, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Important: We may require the original valid paper prescription before lawful supply. Urgent medicines should not rely on postal delivery.',
                        style: GoogleFonts.manrope(
                          fontSize: 12,
                          color: Colors.brown,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class _GuideLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _GuideLink({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.grey),
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
    );
  }
}

class _PrescriptionOption extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const _PrescriptionOption({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.manrope(
                      fontSize: 11,
                      color: AppColors.textLight,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, color: AppColors.grey, size: 18),
          ],
        ),
      ),
    );
  }
}
