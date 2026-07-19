import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';
import 'package:pharmacy_medication/features/home/providers/home_provider.dart';
import 'package:pharmacy_medication/features/services/presentation/screens/vaccination_booking_screen.dart';

class VaccinationScreen extends ConsumerWidget {
  const VaccinationScreen({super.key});

  static const List<Map<String, dynamic>> _vaccines = [
    {
      'name': 'Influenza (Flu)',
      'description': 'Seasonal protection for adults and children.',
      'price': 'From \$25.00',
      'icon': Icons.air,
      'color': Color(0xFF00838F),
      'tag': 'Annual',
    },
    {
      'name': 'Whooping Cough (dTpa)',
      'description': 'Essential for carers and expectant parents.',
      'price': 'From \$45.00',
      'icon': Icons.child_care,
      'color': Color(0xFF6A1B9A),
      'tag': 'Family',
    },
    {
      'name': 'Shingles',
      'description': 'Recommended for older adults.',
      'price': 'Eligibility applies',
      'icon': Icons.elderly,
      'color': Color(0xFFE65100),
      'tag': 'Funded',
    },
    {
      'name': 'COVID-19 Booster',
      'description': 'Stay protected with the latest booster dose.',
      'price': 'Free (eligible)',
      'icon': Icons.coronavirus,
      'color': Color(0xFFC62828),
      'tag': 'Recommended',
    },
    {
      'name': 'Travel Vaccination',
      'description': 'Stay safe on your next international adventure.',
      'price': 'From \$60.00',
      'icon': Icons.flight,
      'color': Color(0xFF1565C0),
      'tag': 'Travel',
    },
    {
      'name': 'Meningococcal',
      'description': 'Protection for teens and young adults.',
      'price': 'Eligibility applies',
      'icon': Icons.school,
      'color': Color(0xFF2E7D32),
      'tag': 'Youth',
    },
  ];

  static const List<Map<String, dynamic>> _steps = [
    {'icon': Icons.vaccines, 'title': 'Select Vaccine', 'desc': 'Choose from our list of available vaccinations'},
    {'icon': Icons.fact_check_outlined, 'title': 'Check Eligibility', 'desc': 'Read & confirm the criteria'},
    {'icon': Icons.calendar_month, 'title': 'Choose Appointment', 'desc': 'Pick a convenient date and time'},
    {'icon': Icons.person_outline, 'title': 'Provide Info', 'desc': 'Enter your personal details'},
    {'icon': Icons.check_circle_outline, 'title': 'Confirm Booking', 'desc': 'Review and confirm your booking'},
    {'icon': Icons.sms_outlined, 'title': 'Get Reminder', 'desc': 'Receive an SMS 24h before your appointment'},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Hero AppBar
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: AppColors.secondary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Colors.white),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  ref.read(bottomNavIndexProvider.notifier).state = 0;
                }
              },
            ),
            title: Text(
              'Vaccination Bookings',
              style: GoogleFonts.manrope(fontWeight: FontWeight.w800, color: Colors.white),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.secondary, Color(0xFF004D40)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -30,
                    top: -20,
                    child: Opacity(
                      opacity: 0.08,
                      child: Icon(Icons.vaccines, size: 200, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '🏥 Kersbrook Pharmacy',
                            style: GoogleFonts.manrope(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Pharmacist Vaccination\nAppointments',
                          style: GoogleFonts.manrope(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Local care for you and your family',
                          style: GoogleFonts.manrope(fontSize: 13, color: Colors.white.withValues(alpha: 0.85)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Quick stats strip
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 12,
                runSpacing: 12,
                children: [
                  _statItem(Icons.timer, '30 min', 'Appointment'),
                  _statItem(Icons.person, 'No referral', 'Required'),
                  _statItem(Icons.star, '5-star', 'Rated service'),
                ],
              ),
            ),
          ),

          // Vaccines grid
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.vaccines, color: AppColors.primary, size: 20),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Available Vaccinations',
                        style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textDark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap a vaccine to book your appointment directly.',
                    style: GoogleFonts.manrope(fontSize: 12, color: AppColors.textLight),
                  ),
                  const SizedBox(height: 16),
                  ...(_vaccines.map((v) => _buildVaccineCard(context, v))),
                ],
              ),
            ),
          ),

          // Booking journey
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, Color(0xFF0D47A1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.route, color: Colors.white, size: 22),
                      const SizedBox(width: 10),
                      Text(
                        'Your Booking Journey',
                        style: GoogleFonts.manrope(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ...(_steps.asMap().entries.map((e) => _buildJourneyStep(e.key + 1, e.value))),
                ],
              ),
            ),
          ),

          // CTA
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const VaccinationBookingScreen(vaccineName: 'General Vaccination'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.calendar_month, size: 20),
                      label: Text(
                        'Book an Appointment',
                        style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'We do not promote specific vaccine brands. Brand availability is subject to stock and pharmacist clinical assessment on the day of your appointment.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(fontSize: 11, color: AppColors.textLight, fontStyle: FontStyle.italic, height: 1.5),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(height: 4),
        Text(value, style: GoogleFonts.manrope(fontWeight: FontWeight.w800, fontSize: 13, color: AppColors.textDark)),
        Text(label, style: GoogleFonts.manrope(fontSize: 11, color: AppColors.textLight)),
      ],
    );
  }

  Widget _divider() {
    return Container(height: 36, width: 1, color: AppColors.inputBorder);
  }

  Widget _buildVaccineCard(BuildContext context, Map<String, dynamic> vaccine) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VaccinationBookingScreen(vaccineName: vaccine['name']),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: (vaccine['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(vaccine['icon'] as IconData, color: vaccine['color'] as Color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          vaccine['name'],
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textDark),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: (vaccine['color'] as Color).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          vaccine['tag'],
                          style: GoogleFonts.manrope(fontSize: 9, fontWeight: FontWeight.w700, color: vaccine['color'] as Color),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    vaccine['description'],
                    style: GoogleFonts.manrope(fontSize: 12, color: AppColors.textLight),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  vaccine['price'],
                  style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.primary),
                ),
                const SizedBox(height: 4),
                const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJourneyStep(int number, Map<String, dynamic> step) {
    final isLast = number == _steps.length;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(step['icon'] as IconData, color: Colors.white, size: 18),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 32,
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: Colors.white.withValues(alpha: 0.2),
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 6, bottom: isLast ? 0 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step['title'],
                  style: GoogleFonts.manrope(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  step['desc'],
                  style: GoogleFonts.manrope(fontSize: 12, color: Colors.white.withValues(alpha: 0.7)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
