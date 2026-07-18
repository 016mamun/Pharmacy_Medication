import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';
import 'package:pharmacy_medication/features/home/providers/home_provider.dart';
import 'package:pharmacy_medication/shared/models/product_model.dart';
import 'package:pharmacy_medication/features/services/presentation/screens/webster_pak_screen.dart';
import 'package:pharmacy_medication/features/services/presentation/screens/vaccination_screen.dart';
import 'package:pharmacy_medication/features/services/presentation/screens/medadvisor_info_screen.dart';
import 'package:pharmacy_medication/shared/widgets/app_network_image.dart';
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

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
            // Section 1: Utility Bar
            const SliverToBoxAdapter(child: _UtilityBar()),

            // Section 2: Header
            const SliverToBoxAdapter(child: _HomeHeader()),

            // Section 3: Hero Banner
            const SliverToBoxAdapter(child: _HeroBanner()),

            // Section 4: Primary Service Cards
            const SliverToBoxAdapter(child: _PrimaryServiceCards()),

            // Section 5: Nationwide Prescription Service
            const SliverToBoxAdapter(child: _NationwideServiceSection()),

            // Section 6: Shop Popular Categories
            const SliverToBoxAdapter(child: _PopularCategories()),

            // Section 7-10: Promotions
            const SliverToBoxAdapter(child: _WebsterPakPromo()),
            const SliverToBoxAdapter(child: _VaccinationPromo()),
            const SliverToBoxAdapter(child: _MedAdvisorPromo()),
            const SliverToBoxAdapter(child: _PharmacistAdvicePromo()),

            // Section 11: Featured Products
            const SliverToBoxAdapter(child: _FeaturedProductsHeader()),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = SampleData.featuredProducts[index];
                    return _ProductCard(product: product);
                  },
                  childCount: SampleData.featuredProducts.length,
                ),
              ),
            ),

            // Section 12: Local Pharmacy Section
            const SliverToBoxAdapter(child: _LocalPharmacySection()),

            // Section 13: Health Information
            const SliverToBoxAdapter(child: _HealthInformationSection()),

            // Section 14: Trust Strip
            const SliverToBoxAdapter(child: _TrustStrip()),

            // Section 15: Footer
            const SliverToBoxAdapter(child: _AppFooter()),
          ],
        ),
    );
  }
}

class _UtilityBar extends StatelessWidget {
  const _UtilityBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      color: AppColors.primaryLight,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 4,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.phone, size: 14, color: AppColors.primary),
              const SizedBox(width: 4),
              Text(
                '08 8389 1205',
                style: GoogleFonts.manrope(fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Text(
            'Adelaide Hills • Nationwide Delivery',
            style: GoogleFonts.manrope(fontSize: 11, fontWeight: FontWeight.w600),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Flexible(
            child: Image.asset(
              'assets/pharmacist_advice.png',
              height: 40,
              fit: BoxFit.contain,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen()));
                },
                icon: const Icon(Icons.search),
              ),
              const SizedBox(width: 4),
              // Cart icon with badge
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                  ),
                  if (cartCount > 0)
                    Positioned(
                      top: 6,
                      right: 6,
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
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroBanner extends ConsumerWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: AppNetworkImage(
              imageUrl: 'https://images.pexels.com/photos/5910953/pexels-photo-5910953.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: AppColors.secondary.withValues(alpha: 0.7),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your trusted Kersbrook pharmacy—now delivering prescriptions across Australia',
                  style: GoogleFonts.manrope(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Order prescriptions, shop pharmacy essentials, book vaccinations and access personal pharmacist support.',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          ref.read(bottomNavIndexProvider.notifier).state = 2;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                        ),
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Order Prescription',
                            maxLines: 1,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          ref.read(bottomNavIndexProvider.notifier).state = 1;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                        ),
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Shop Online',
                            maxLines: 1,
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryServiceCards extends ConsumerWidget {
  const _PrimaryServiceCards();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.82,
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
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              height: 45, // Fixed height so the button is perfectly aligned across all cards
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  color: AppColors.textLight,
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              buttonText,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NationwideServiceSection extends StatelessWidget {
  const _NationwideServiceSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      padding: const EdgeInsets.all(24),
      color: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prescription delivery beyond the Adelaide Hills',
            style: GoogleFonts.manrope(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Kersbrook Pharmacy supports eligible patients throughout Australia with convenient prescription ordering and delivery.',
            style: GoogleFonts.manrope(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          _stepRow('1', 'Send or order your prescription'),
          _stepRow('2', 'A pharmacist reviews and confirms supply'),
          _stepRow('3', 'Select an available delivery option'),
          _stepRow('4', 'Receive tracking information'),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _ActionButton(text: 'Send eScript', onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const EScriptSubmissionScreen()));
              }),
              _ActionButton(text: 'Use MedAdvisor', onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MedAdvisorInfoScreen()));
              }),
              _ActionButton(text: 'Ask a Pharmacist', onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PharmacistAdviceFormScreen()));
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stepRow(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.manrope(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _ActionButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12)),
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
      imageUrl: 'https://images.pexels.com/photos/5910956/pexels-photo-5910956.jpeg?auto=compress&cs=tinysrgb&w=800',
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
      imageUrl: 'https://images.pexels.com/photos/3992933/pexels-photo-3992933.jpeg?auto=compress&cs=tinysrgb&w=800',
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
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7FF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.app_shortcut, color: Colors.blue, size: 32),
              const SizedBox(width: 12),
              Text(
                'Manage with MedAdvisor',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF004080),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _benefitRow('Order prescriptions and repeats'),
          _benefitRow('Receive medicine reminders'),
          _benefitRow('Select collection or delivery'),
          _benefitRow('Manage medicines for family members'),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MedAdvisorInfoScreen()));
              }, child: const Text('Log In')),
              TextButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MedAdvisorInfoScreen()));
              }, child: const Text('How It Works')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _benefitRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: GoogleFonts.manrope(fontSize: 13))),
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
                Text(buttonText, style: const TextStyle(fontWeight: FontWeight.bold)),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailsScreen(product: product)));
      },
      child: Container(
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
                children: [
                  Text(
                    product.name,
                    style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${product.price.toStringAsFixed(2)} AUD',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocalPharmacySection extends StatelessWidget {
  const _LocalPharmacySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
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
            child: AppNetworkImage(
              imageUrl: 'https://images.pexels.com/photos/208512/pexels-photo-208512.jpeg?auto=compress&cs=tinysrgb&w=800',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          const _InfoRow(icon: Icons.location_on, text: '16 Scott St, Kersbrook SA 5231'),
          const _InfoRow(icon: Icons.access_time, text: 'Mon-Fri: 9am-6pm | Sat: 9am-12pm'),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              child: const Text('View Location & Hours'),
            ),
          ),
        ],
      ),
    );
  }
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
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 200,
                margin: const EdgeInsets.symmetric(horizontal: 6),
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
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppNetworkImage(
                      imageUrl: 'https://images.pexels.com/photos/5910960/pexels-photo-5910960.jpeg?auto=compress&cs=tinysrgb&w=600',
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Understanding Vitamin D',
                            style: GoogleFonts.manrope(fontSize: 13, fontWeight: FontWeight.w700),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Reviewed by Pharmacist • May 2024',
                            style: GoogleFonts.manrope(fontSize: 10, color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
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
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          Text(
            'KERSBROOK PHARMACY',
            style: GoogleFonts.manrope(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 18,
              letterSpacing: 1.0,
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
