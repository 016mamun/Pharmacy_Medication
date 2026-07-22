import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';
import 'package:pharmacy_medication/features/profile/presentation/screens/contact_screen.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  static const List<Map<String, String>> _faqs = [
    {
      'q': 'How do I submit a prescription?',
      'a': 'You can submit a prescription by using our eScript submission form. Simply take a photo of your prescription or enter your eScript token and we will process it promptly.',
    },
    {
      'q': 'How long does delivery take?',
      'a': 'Standard delivery typically takes 3–7 business days Australia-wide. Express options may be available at checkout depending on your location.',
    },
    {
      'q': 'Can I track my order?',
      'a': 'Yes! Once your order is dispatched, you will receive an email with a tracking number so you can monitor your delivery in real time.',
    },
    {
      'q': 'What is Webster-pak?',
      'a': 'Webster-pak is a blister-pack system that organises your medicines by day and time. It is free to eligible patients and helps reduce missed doses.',
    },
    {
      'q': 'How do I book a vaccination?',
      'a': 'Navigate to the Services section and tap "Vaccinations". You can view available vaccines and request a booking online.',
    },
    {
      'q': 'Is my information kept private?',
      'a': 'Absolutely. We comply with the Australian Privacy Act. Your personal and medical information is never shared without your consent.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primary, AppColors.darkGreen],
                ),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  Text('Help & Support', style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contact Quick Options
                    Row(
                      children: [
                        Expanded(child: _contactCard(context, icon: Icons.phone_rounded, label: 'Call Us', sub: '08 8389 1205', color: const Color(0xFF1565C0))),
                        const SizedBox(width: 12),
                        Expanded(child: _contactCard(context, icon: Icons.email_rounded, label: 'Email Us', sub: 'Send enquiry', color: const Color(0xFF2E7D32), onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactScreen()));
                        })),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text('Frequently Asked Questions', style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textDark)),
                    const SizedBox(height: 12),
                    ..._faqs.map((faq) => _FaqItem(question: faq['q']!, answer: faq['a']!)),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            const Icon(Icons.store_rounded, color: AppColors.primary, size: 20),
                            const SizedBox(width: 10),
                            Text('Visit Us In Store', style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
                          ]),
                          const SizedBox(height: 8),
                          Text('1264 Torrens Valley Road\nKersbrook SA 5231', style: GoogleFonts.manrope(fontSize: 13, color: AppColors.textDark, height: 1.5)),
                          const SizedBox(height: 4),
                          Text('Mon–Fri: 9am–5:30pm\nSat: 9am–12:30pm', style: GoogleFonts.manrope(fontSize: 12, color: AppColors.textLight, height: 1.5)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactCard(BuildContext context, {required IconData icon, required String label, required String sub, required Color color, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 12),
            Text(label, style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
            Text(sub, style: GoogleFonts.manrope(fontSize: 11, color: AppColors.textLight)),
          ],
        ),
      ),
    );
  }
}

class _FaqItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});

  @override
  State<_FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<_FaqItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          initiallyExpanded: _expanded,
          onExpansionChanged: (v) => setState(() => _expanded = v),
          leading: Container(
            width: 32, height: 32,
            decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.help_outline_rounded, color: AppColors.primary, size: 16),
          ),
          title: Text(widget.question, style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textDark)),
          children: [
            Text(widget.answer, style: GoogleFonts.manrope(fontSize: 13, color: AppColors.textLight, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
