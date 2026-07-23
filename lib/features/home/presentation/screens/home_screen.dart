import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/shared/widgets/card_3d.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';
import 'package:pharmacy_medication/features/home/providers/home_provider.dart';
import 'package:pharmacy_medication/shared/models/product_model.dart';
import 'package:pharmacy_medication/features/services/presentation/screens/webster_pak_screen.dart';
import 'package:pharmacy_medication/features/services/presentation/screens/vaccination_screen.dart';
import 'package:pharmacy_medication/features/services/presentation/screens/medadvisor_info_screen.dart';
import 'package:pharmacy_medication/features/cart/providers/cart_provider.dart';

import 'package:pharmacy_medication/features/cart/presentation/screens/cart_screen.dart';
import 'package:pharmacy_medication/features/shop/presentation/screens/product_details_screen.dart';

import 'package:pharmacy_medication/features/profile/presentation/screens/contact_screen.dart';
import 'package:pharmacy_medication/features/search/presentation/screens/search_screen.dart';
import 'package:pharmacy_medication/features/about/presentation/screens/about_screen.dart';
import 'package:pharmacy_medication/features/about/presentation/screens/legal_pages_screen.dart';
import 'package:pharmacy_medication/features/about/presentation/screens/delivery_info_screen.dart';

import 'package:pharmacy_medication/features/prescription/presentation/screens/escript_submission_screen.dart';
import 'package:pharmacy_medication/features/prescription/presentation/screens/pharmacist_advice_form_screen.dart';
import 'package:pharmacy_medication/features/health_advice/presentation/screens/health_advice_article_screen.dart';
import 'package:pharmacy_medication/shared/widgets/app_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 350;
          return CustomScrollView(
            slivers: [
              // Section 1: Utility Bar
              const SliverToBoxAdapter(child: _UtilityBar()),

              // Section 2: Header
              const SliverToBoxAdapter(child: _HomeHeader()),

              // Section 3: Hero Banner Carousel
              const SliverToBoxAdapter(child: _HeroBanner()),

              // Section 4: Feature Cards (horizontal scroll)
              const SliverToBoxAdapter(child: _FeatureCardsSection()),

              // Section 5: More Services Grid
              const SliverToBoxAdapter(child: _MoreServicesSection()),

              // Section 5.5: Webster Banner Card
              const SliverToBoxAdapter(child: _WebsterBannerCard()),

              // Section 6: Primary Service Cards
              const SliverToBoxAdapter(child: _PrimaryServiceCards()),

              // Section 7: Nationwide Prescription Service
              const SliverToBoxAdapter(child: _NationwideServiceSection()),

              // Section 8: Health Information
              const SliverToBoxAdapter(child: _HealthInformationSection()),
            ],
          );
        },
      ),
    );
  }
}

class _UtilityBar extends StatelessWidget {
  const _UtilityBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      color: AppColors.primaryLight,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 4,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(Icons.phone, size: 14, color: AppColors.primary),
              const SizedBox(width: 4),
              Text(
                '08 8389 1205',
                style: GoogleFonts.manrope(fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Adelaide Hills • Nationwide Delivery',
              style: GoogleFonts.manrope(fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeHeader extends ConsumerWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount = ref.watch(cartCountProvider);
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 300;
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 12, 8),
          child: Row(
            children: [
              // High-resolution Logo
              Expanded(
                flex: 7,
                child: Image.asset(
                  'assets/pharmacist_advice.png',
                  height: isNarrow ? 28 : 40,
                  fit: BoxFit.contain,
                  alignment: Alignment.centerLeft,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 4,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        constraints: isNarrow ? const BoxConstraints(maxWidth: 32) : const BoxConstraints(maxWidth: 40),
                        padding: isNarrow ? EdgeInsets.zero : null,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()));
                        },
                        icon: Icon(Icons.search, size: isNarrow ? 20 : 24),
                      ),
                      const SizedBox(width: 4),
                      // Cart icon with badge
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              Icon(Icons.shopping_cart_outlined, size: isNarrow ? 20 : 24),
                              if (cartCount > 0)
                                Positioned(
                                  top: -4,
                                  right: -4,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: const BoxDecoration(
                                      color: AppColors.accent,
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      cartCount > 9 ? '9+' : '$cartCount',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      IconButton(
                        constraints: isNarrow ? const BoxConstraints(maxWidth: 32) : const BoxConstraints(maxWidth: 40),
                        padding: isNarrow ? EdgeInsets.zero : null,
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        icon: Icon(Icons.menu, size: isNarrow ? 20 : 24),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class _HeroBanner extends StatefulWidget {
  const _HeroBanner();

  @override
  State<_HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<_HeroBanner> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  static const List<String> _slides = [
    'assets/Banner/2.1.png',
    'assets/Banner/2.2.png',
    'assets/Banner/2.3.png',
    'assets/Banner/2.4.png',
    'assets/Banner/2.5.png',
    'assets/Banner/2.6.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          CarouselSlider(
            carouselController: _controller,
            items: _slides.map((imagePath) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.broken_image_outlined,
                          color: Colors.grey, size: 40),
                    ),
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              aspectRatio: 2.1,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 700),
              autoPlayCurve: Curves.easeInOut,
              onPageChanged: (index, _) {
                setState(() => _currentIndex = index);
              },
            ),
          ),
          const SizedBox(height: 10),
          AnimatedSmoothIndicator(
            activeIndex: _currentIndex,
            count: _slides.length,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.primary,
              dotColor: AppColors.primary.withValues(alpha: 0.25),
              dotHeight: 6,
              dotWidth: 6,
              expansionFactor: 3,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// Feature Cards Section (horizontal scroll)
// ──────────────────────────────────────────────────────────

class _FeatureCardsSection extends StatelessWidget {
  const _FeatureCardsSection();

  static const List<Map<String, dynamic>> _features = [
    {
      'icon': Icons.video_call_rounded,
      'badge': 'NEW',
      'title': 'Monthly Video Call',
      'subtitle': 'by a Geriatric Pharmacist',
      'description': 'Personalised support, medication education and answers to your questions — from the comfort of your home.',
      'color': Color(0xFF1565C0),
      'bgColor': Color(0xFFE3F2FD),
    },
    {
      'icon': Icons.local_shipping_rounded,
      'badge': null,
      'title': 'FREE Delivery',
      'subtitle': 'Australia Wide',
      'description': 'Your Webster-paks® and prescriptions delivered safely to your door — anywhere in Australia, at no extra cost.',
      'color': Color(0xFF2E7D32),
      'bgColor': Color(0xFFE8F5E9),
    },
    {
      'icon': Icons.fact_check_rounded,
      'badge': null,
      'title': 'Complimentary',
      'subtitle': 'Medication Review',
      'description': 'Once a year, our pharmacists review your medicines to help ensure they are safe, effective and right for you.',
      'color': Color(0xFFE65100),
      'bgColor': Color(0xFFFFF3E0),
    },
    {
      'icon': Icons.verified_rounded,
      'badge': null,
      'title': 'Medication',
      'subtitle': 'Change Promise™',
      'description': 'If your medication changes, eligible unused PBS medicines may qualify for a discretionary store credit or discount.',
      'color': Color(0xFF6A1B9A),
      'bgColor': Color(0xFFF3E5F5),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Why Choose Us',
                  style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textDark),
                ),
                Row(
                  children: [
                    Text(
                      'See All',
                      style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppColors.primary),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 185, // Further decreased height to reduce the gap
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(bottom: 12),
              itemCount: _features.length,
              itemBuilder: (context, index) {
                final f = _features[index];
                final color = f['color'] as Color;
                final bgColor = f['bgColor'] as Color;
                final badge = f['badge'] as String?;
                return Container(
                  width: 245, // Increased width to prevent text wrapping/overlap
                  margin: EdgeInsets.only(right: index == _features.length - 1 ? 0 : 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.10),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: color.withValues(alpha: 0.12)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                                child: Icon(f['icon'] as IconData, color: Colors.white, size: 24),
                              ),
                              if (badge != null)
                                Positioned(
                                  top: -4,
                                  right: -12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.accent, // Red color
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(badge, style: GoogleFonts.manrope(fontSize: 9, fontWeight: FontWeight.w800, color: Colors.white)),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 18), // Increased spacing so badge doesn't overlap text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  f['title'] as String,
                                  style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textDark, height: 1.2),
                                ),
                                Text(
                                  f['subtitle'] as String,
                                  style: GoogleFonts.manrope(fontSize: 11, fontWeight: FontWeight.w700, color: color),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Text(
                          f['description'] as String,
                          style: GoogleFonts.manrope(fontSize: 11, color: AppColors.textLight, height: 1.4),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text('Learn More', style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textDark)),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                            child: const Icon(Icons.arrow_forward_rounded, size: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// More Services Grid Section
// ──────────────────────────────────────────────────────────

class _MoreServicesSection extends StatelessWidget {
  const _MoreServicesSection();

  static const List<Map<String, dynamic>> _services = [
    {'icon': Icons.vaccines_outlined, 'title': 'Vaccination', 'subtitle': 'Flu, COVID-19 & more'},
    {'icon': Icons.favorite_border_rounded, 'title': 'Heart Health', 'subtitle': 'Know your heart health'},
    {'icon': Icons.bloodtype_outlined, 'title': 'BP', 'subtitle': 'Blood pressure check'},
    {'icon': Icons.monitor_heart_outlined, 'title': 'BGL', 'subtitle': 'Blood glucose check'},
    {'icon': Icons.air_outlined, 'title': 'Inhaler Technique', 'subtitle': 'Breathe with confidence'},
    {'icon': Icons.science_outlined, 'title': 'Compounding', 'subtitle': 'Custom medicines'},
    {'icon': Icons.receipt_long_outlined, 'title': 'Online Scripts', 'subtitle': 'Fast & convenient'},
    {'icon': Icons.shopping_cart_outlined, 'title': 'Shop Online', 'subtitle': 'Vitamins & more'},
    {'icon': Icons.medication_outlined, 'title': 'Free Webster-pak®', 'subtitle': 'Medication packs'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 32),
        Text('MORE THAN A PHARMACY', style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.red.shade700, letterSpacing: 1.2)),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Expert Care. More Services. Better Health.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.primary, height: 1.2),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 400;
              final crossAxisCount = isNarrow ? 3 : 4;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisExtent: 140, // Fixed height to prevent huge gaps!
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 16,
                ),
                itemCount: _services.length,
                itemBuilder: (context, index) {
                  final service = _services[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.05)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary.withValues(alpha: 0.15),
                              AppColors.primary.withValues(alpha: 0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(service['icon'] as IconData, color: AppColors.primary, size: 24),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        service['title'] as String,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.textDark, height: 1.1),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service['subtitle'] as String,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textLight, height: 1.2),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            );
          }
        ),
      ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _PrimaryServiceCards extends ConsumerWidget {
  const _PrimaryServiceCards();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 300;
          return GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isNarrow ? 1 : (constraints.maxWidth > 600 ? 4 : 2),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              mainAxisExtent: 180,
            ),
            children: [
              _ServiceCard(
                title: 'Order prescriptions',
                description: 'Send an eScript, order repeats or manage regular medicines.',
                icon: Icons.medication,
                buttonText: 'Order Now',
                color: const Color(0xFFE3F2FD),
                iconColor: Colors.blue,
                onTap: () {
                  ref.read(bottomNavIndexProvider.notifier).state = 2;
                },
              ),
              _ServiceCard(
                title: 'Free Webster-pak®',
                description: 'Regular medicines professionally organised by day and time.',
                icon: Icons.calendar_view_month,
                buttonText: 'Register Now',
                color: const Color(0xFFFFF3E0),
                iconColor: Colors.orange,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const WebsterPakScreen()),
                  );
                },
              ),
              _ServiceCard(
                title: 'Shop online',
                description: 'Browse eligible pharmacy, health, beauty and home-care products.',
                icon: Icons.shopping_bag,
                buttonText: 'Shop Now',
                color: const Color(0xFFF1F8E9),
                iconColor: Colors.green,
                onTap: () {
                  ref.read(bottomNavIndexProvider.notifier).state = 1;
                },
              ),
              _ServiceCard(
                title: 'Vaccinations',
                description: 'View available pharmacist vaccination services and book online.',
                icon: Icons.vaccines,
                buttonText: 'Book Now',
                color: const Color(0xFFF3E5F5),
                iconColor: Colors.purple,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const VaccinationScreen()),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final String buttonText;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.buttonText,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card3D(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 36,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: Center(
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  color: AppColors.textLight,
                  height: 1.2,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────
// Webster Banner Card Section
// ──────────────────────────────────────────────────────────

class _WebsterBannerCard extends StatelessWidget {
  const _WebsterBannerCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Banner image card
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/webster_banner.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 160,
                      color: AppColors.primaryLight,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.calendar_view_month, color: AppColors.primary, size: 48),
                            const SizedBox(height: 8),
                            Text(
                              'Free Webster-pak®',
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const WebsterPakScreen()),
                          );
                        },
                        splashColor: Colors.white.withValues(alpha: 0.15),
                        highlightColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          // "Learn More About Webster®" red button — below the image
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const WebsterPakScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCC1B1B),
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor: const Color(0xFFCC1B1B).withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Learn More About Webster®',
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.2,
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          // HOW IT WORKS header
          Text(
            'HOW IT WORKS',
            style: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: const Color(0xFFCC1B1B),
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '4 Simple Steps',
            style: GoogleFonts.manrope(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 20),

          // 4 Steps horizontal scroll
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _WebsterStep(
                  number: '1',
                  icon: Icons.phone_rounded,
                  title: 'Contact Us',
                  description: 'Call, email or complete our online form.',
                ),
                const _StepArrow(),
                _WebsterStep(
                  number: '2',
                  icon: Icons.assignment_rounded,
                  title: 'We Organise Everything',
                  description: 'We liaise with your doctor & handle the paperwork.',
                ),
                const _StepArrow(),
                _WebsterStep(
                  number: '3',
                  icon: Icons.medication_rounded,
                  title: 'We Prepare Your Medicines',
                  description: 'Professionally packed & pharmacist checked with care.',
                ),
                const _StepArrow(),
                _WebsterStep(
                  number: '4',
                  icon: Icons.local_shipping_rounded,
                  title: 'FREE Delivery to Your Door',
                  description: 'Delivered anywhere in Australia.',
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _WebsterStep extends StatelessWidget {
  final String number;
  final IconData icon;
  final String title;
  final String description;

  const _WebsterStep({
    required this.number,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon circle
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.07),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.15),
                width: 1.5,
              ),
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(height: 8),
          // Red number
          Text(
            number,
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: const Color(0xFFCC1B1B),
            ),
          ),
          const SizedBox(height: 4),
          // Bold title
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 4),
          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColors.textLight,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _StepArrow extends StatelessWidget {
  const _StepArrow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, left: 4, right: 4),
      child: Icon(
        Icons.arrow_forward_rounded,
        color: AppColors.primary.withValues(alpha: 0.4),
        size: 20,
      ),
    );
  }
}

class _NationwideServiceSection extends StatelessWidget {
  const _NationwideServiceSection();

  @override
  Widget build(BuildContext context) {



    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF0D47A1)], // Deep blue gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.local_shipping_outlined, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Prescription delivery beyond the Adelaide Hills',
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Kersbrook Pharmacy supports eligible patients throughout Australia with convenient prescription ordering and delivery.',
            style: GoogleFonts.manrope(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          _stepRow('1', 'Send or order your prescription', Icons.receipt_long),
          _stepRow('2', 'A pharmacist reviews and confirms supply', Icons.fact_check_outlined),
          _stepRow('3', 'Select an available delivery option', Icons.local_shipping_outlined),
          _stepRow('4', 'Receive tracking information', Icons.location_on_outlined),
          const SizedBox(height: 32),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const EScriptSubmissionScreen()));
                      },
                      icon: const Icon(Icons.send, size: 16, color: AppColors.primary),
                      label: const FittedBox(child: Text('Send eScript')),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                        textStyle: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ActionButton(
                      text: 'Use MedAdvisor',
                      icon: Icons.phone_android,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const MedAdvisorInfoScreen()));
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Center(
                child: _ActionButton(
                  text: 'Ask a Pharmacist',
                  icon: Icons.chat_bubble_outline,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PharmacistAdviceFormScreen()));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stepRow(String number, String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: GoogleFonts.manrope(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.manrope(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
          Icon(icon, color: Colors.white.withValues(alpha: 0.4), size: 20),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const _ActionButton({required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: FittedBox(child: Text(text)),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.white.withValues(alpha: 0.5)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _PopularCategories extends ConsumerWidget {
  const _PopularCategories();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = [
      {'name': 'Pain Relief', 'icon': Icons.healing},
      {'name': 'Cold & Flu', 'icon': Icons.ac_unit},
      {'name': 'Vitamins', 'icon': Icons.wb_sunny},
      {'name': 'Skin Care', 'icon': Icons.face},
      {'name': 'Baby & Child', 'icon': Icons.child_care},
      {'name': 'First Aid', 'icon': Icons.medical_services},
      {'name': 'Oral Care', 'icon': Icons.brush},
      {'name': 'Home Health', 'icon': Icons.home_repair_service},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Text(
            'Shop Popular Categories',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  ref.read(bottomNavIndexProvider.notifier).state = 1;
                },
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(categories[index]['icon'] as IconData, color: AppColors.primary),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        categories[index]['name'] as String,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w600),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _WebsterPakPromo extends StatelessWidget {
  const _WebsterPakPromo();

  @override
  Widget build(BuildContext context) {
    return _PromoSection(
      title: 'Free Webster-pak® medication packing',
      content: 'Make regular medicines easier to manage. Our pharmacists can organise suitable tablets and capsules into clearly labelled medication packs.',
      buttonText: 'Start the Service',
      imageUrl: 'assets/Webster-pak.jpg',
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const WebsterPakScreen()));
      },
    );
  }
}

class _VaccinationPromo extends StatelessWidget {
  const _VaccinationPromo();

  @override
  Widget build(BuildContext context) {
    return _PromoSection(
      title: 'Pharmacist vaccination appointments',
      content: 'Book an appointment for vaccinations currently available through Kersbrook Pharmacy. Eligibility and availability confirmed during booking.',
      buttonText: 'Book Online',
      imageUrl: 'assets/vaccinations.png',
      isReversed: true,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const VaccinationScreen()));
      },
    );
  }
}

class _MedAdvisorPromo extends StatelessWidget {
  const _MedAdvisorPromo();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 320;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Container(
            padding: EdgeInsets.all(isNarrow ? 16 : 20),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F9FF),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.app_shortcut, color: Colors.blue, size: 32),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Manage with MedAdvisor',
                        style: GoogleFonts.manrope(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF004080),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _benefitRow('Order prescriptions and repeats'),
                _benefitRow('Receive medicine reminders'),
                _benefitRow('Select collection or delivery'),
                _benefitRow('Manage medicines for family members'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const MedAdvisorInfoScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004080),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        shape: const StadiumBorder(),
                        elevation: 0,
                      ),
                      child: const Text('Log In', style: TextStyle(fontSize: 14)),
                    ),
                    const SizedBox(width: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const MedAdvisorInfoScreen()));
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF004080),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      child: const Text('How It Works', style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _benefitRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text, 
              style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w500)
            ),
          ),
        ],
      ),
    );
  }
}

class _PharmacistAdvicePromo extends StatelessWidget {
  const _PharmacistAdvicePromo();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            'Professional advice from a real pharmacist',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Online convenience should not replace pharmacist care. Contact us for advice about medicines, interactions and side effects.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(fontSize: 13, color: AppColors.textLight),
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PharmacistAdviceFormScreen()));
                },
                icon: const Icon(Icons.chat_bubble_outline, size: 18),
                label: const Text('Ask a Pharmacist'),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  // Direct to contact/call functionality
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactScreen()));
                },
                icon: const Icon(Icons.phone, size: 18),
                label: const Text('Call Us'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PromoSection extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final String imageUrl;
  final bool isReversed;
  final VoidCallback? onTap;

  const _PromoSection({
    required this.title,
    required this.content,
    required this.buttonText,
    required this.imageUrl,
    this.isReversed = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AppNetworkImage(
                imageUrl: imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.manrope(fontSize: 13, color: AppColors.textLight, height: 1.5),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              foregroundColor: AppColors.primary,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(buttonText, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                const Icon(Icons.arrow_forward, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedProductsHeader extends ConsumerWidget {
  const _FeaturedProductsHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        runSpacing: 4,
        children: [
          Text(
            'Selected Pharmacy Essentials',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),
          GestureDetector(
            onTap: () => ref.read(bottomNavIndexProvider.notifier).state = 1,
            child: Text(
              'View All',
              style: GoogleFonts.manrope(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductModel product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card3D(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product)));
      },
      borderRadius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: AppNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  product.name,
                  style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${product.price.toStringAsFixed(2)} AUD',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LocalPharmacySection extends StatelessWidget {
  const _LocalPharmacySection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card3D(
        borderRadius: 24,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Proudly serving Kersbrook and the Adelaide Hills',
              style: GoogleFonts.manrope(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 150,
                width: double.infinity,
                color: const Color(0xFFE8EAED),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _MapPainterPlaceholder(),
                      ),
                    ),
                    const Center(
                      child: Icon(
                        Icons.location_on_rounded,
                        color: Color(0xFFE74C3C),
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const _InfoRow(icon: Icons.location_on, text: '16 Scott St, Kersbrook SA 5231'),
            const _InfoRow(icon: Icons.access_time, text: 'Mon-Fri: 9am-6pm | Sat: 9am-12pm'),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactScreen()));
                },
                child: const Text('View Location & Hours'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapPainterPlaceholder extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFE8EAED);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final roadPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Drawing basic road lines for a "map" look
    for (var i = 0; i < 5; i++) {
      final y = size.height * 0.1 + i * size.height * 0.25;
      canvas.drawRect(Rect.fromLTWH(0, y, size.width, 6), roadPaint);
    }

    for (var i = 0; i < 4; i++) {
      final x = size.width * 0.15 + i * size.width * 0.28;
      canvas.drawRect(Rect.fromLTWH(x, 0, 6, size.height), roadPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: GoogleFonts.manrope(fontSize: 12))),
        ],
      ),
    );
  }
}

class _HealthInformationSection extends StatelessWidget {
  const _HealthInformationSection();

  @override
  Widget build(BuildContext context) {
    final articles = [
      {
        'title': 'Understanding Vitamin D',
        'subtitle': 'Reviewed by Pharmacist • May 2024',
        'image': 'assets/health/Vitamin_D.jpg'
      },
      {
        'title': 'Managing Seasonal Allergies',
        'subtitle': 'Reviewed by Pharmacist • Apr 2024',
        'image': 'assets/health/managing_seasonal_allergies.jpg'
      },
      {
        'title': 'Heart Health Fundamentals',
        'subtitle': 'Reviewed by Pharmacist • Mar 2024',
        'image': 'assets/health/heart_health_fundamentals.jpg'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Text(
            'Health Information',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),
        ),
        SizedBox(
          height: 195, // Optimized height to prevent overflow while keeping it tight
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(6, 4, 6, 12), // Reduced top, added more bottom room for shadow
                child: SizedBox(
                  width: 200,
                  child: Card3D(
                    borderRadius: 20,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HealthAdviceArticleScreen(
                            title: article['title']!,
                            imageUrl: article['image']!,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppNetworkImage(
                          imageUrl: article['image']!,
                          height: 90, // Slightly reduced image height
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 10), // Tightened padding
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 36, // Tightened title box
                                child: Text(
                                  article['title']!,
                                  style: GoogleFonts.manrope(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    height: 1.15,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 2), // Minimal gap
                              Text(
                                article['subtitle']!,
                                style: GoogleFonts.manrope(
                                  fontSize: 10, 
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TrustStrip extends StatelessWidget {
  const _TrustStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      color: Colors.white,
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 12,
        runSpacing: 16,
        children: [
          _TrustItem(icon: Icons.verified_user, label: 'Registered\nPharmacy'),
          _TrustItem(icon: Icons.local_shipping, label: 'Nationwide\nDelivery'),
          _TrustItem(icon: Icons.security, label: 'Secure\nOrdering'),
        ],
      ),
    );
  }
}

class _TrustItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _TrustItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.textDark),
        ),
      ],
    );
  }
}

class _AppFooter extends StatelessWidget {
  const _AppFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondary,
      padding: const EdgeInsets.fromLTRB(32, 32, 32, 100),
      child: Column(
        children: [
          const Icon(Icons.local_pharmacy, color: Colors.white, size: 40),
          const SizedBox(height: 16),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'KERSBROOK PHARMACY',
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 18,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your local Adelaide Hills pharmacy, delivering trusted pharmacist care across Australia.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(color: Colors.white.withValues(alpha: 0.7), fontSize: 12, height: 1.5),
          ),
          const SizedBox(height: 32),
          const Divider(color: Colors.white24),
          const SizedBox(height: 24),
          _footerLink('About Kersbrook Pharmacy', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen()))),
          _footerLink('Privacy Policy', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LegalPagesScreen()))),
          _footerLink('Terms of Service', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LegalPagesScreen()))),
          _footerLink('Shipping & Delivery', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DeliveryInfoScreen()))),
          const SizedBox(height: 32),
          Text(
            '© 2024 Kersbrook Pharmacy. All Rights Reserved.',
            style: GoogleFonts.manrope(color: Colors.white38, fontSize: 10),
          ),
          const SizedBox(height: 8),
          Text(
            'ABN: 12 345 678 910',
            style: GoogleFonts.manrope(color: Colors.white38, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _footerLink(String label, [VoidCallback? onTap]) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          label,
          style: GoogleFonts.manrope(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            decoration: onTap != null ? TextDecoration.underline : null,
            decorationColor: Colors.white54,
          ),
        ),
      ),
    );
  }
}
