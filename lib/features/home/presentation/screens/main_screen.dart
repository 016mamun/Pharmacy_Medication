import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/features/home/providers/home_provider.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';
import 'package:pharmacy_medication/features/home/presentation/screens/home_screen.dart';
import 'package:pharmacy_medication/features/prescription/presentation/screens/prescription_screen.dart';
import 'package:pharmacy_medication/features/shop/presentation/screens/shop_screen.dart';
import 'package:pharmacy_medication/features/profile/presentation/screens/contact_screen.dart';
import 'package:pharmacy_medication/features/services/presentation/screens/vaccination_screen.dart';

import 'package:pharmacy_medication/features/services/presentation/screens/services_list_screen.dart';
import 'package:pharmacy_medication/features/health_advice/presentation/screens/health_advice_screen.dart';
import 'package:pharmacy_medication/features/about/presentation/screens/about_screen.dart';
import 'package:pharmacy_medication/features/about/presentation/screens/delivery_info_screen.dart';
import 'package:pharmacy_medication/features/about/presentation/screens/legal_pages_screen.dart';
import 'package:pharmacy_medication/features/prescription/presentation/screens/pharmacist_advice_form_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final screens = [
      const HomeScreen(),
      const ShopScreen(),
      const PrescriptionScreen(),
      const ContactScreen(),
      const VaccinationScreen(),
    ];

    return PopScope(
      canPop: currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          ref.read(bottomNavIndexProvider.notifier).state = 0;
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.background,
        drawer: _AppDrawer(scaffoldKey: scaffoldKey),
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const PharmacistAdviceFormScreen()));
          },
          backgroundColor: Colors.blue,
          elevation: 4,
          shape: const CircleBorder(),
          child: const Icon(Icons.chat_bubble, color: Colors.white),
        ),
        bottomNavigationBar: const _StickyBottomActionBar(),
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const _AppDrawer({required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.primary),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.local_pharmacy, color: Colors.white, size: 40),
                  const SizedBox(height: 12),
                  Text(
                    'KERSBROOK PHARMACY',
                    style: GoogleFonts.manrope(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          _drawerItem(context, Icons.medical_services, 'Pharmacy Services', const ServicesListScreen()),
          _drawerItem(context, Icons.favorite_outline, 'Health Advice', const HealthAdviceScreen()),
          _drawerItem(context, Icons.info_outline, 'About Us', const AboutScreen()),
          _drawerItem(context, Icons.chat_bubble_outline, 'Ask a Pharmacist', const PharmacistAdviceFormScreen()),
          _drawerItem(context, Icons.local_shipping_outlined, 'Delivery Information', const DeliveryInfoScreen()),
          _drawerItem(context, Icons.gavel_outlined, 'Legal & Policies', const LegalPagesScreen()),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Your trusted Adelaide Hills pharmacy',
              style: GoogleFonts.manrope(fontSize: 11, color: AppColors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context, IconData icon, String title, Widget? screen) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
      onTap: () {
        Navigator.pop(context); // Close drawer
        if (screen != null) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
        }
      },
    );
  }
}

class _StickyBottomActionBar extends ConsumerWidget {
  const _StickyBottomActionBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return SafeArea(
      top: false,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _BottomBarItem(
                icon: Icons.medication,
                label: 'Prescription',
                isActive: currentIndex == 2,
                onTap: () => ref.read(bottomNavIndexProvider.notifier).state = 2,
              ),
            ),
            Expanded(
              child: _BottomBarItem(
                icon: Icons.shopping_bag,
                label: 'Shop',
                isActive: currentIndex == 1,
                onTap: () => ref.read(bottomNavIndexProvider.notifier).state = 1,
              ),
            ),
            // Center Home button or different layout?
            // Brief says: Order Prescription, Shop, Call, Book
            Expanded(
              child: _BottomBarItem(
                icon: Icons.home,
                label: 'Home',
                isActive: currentIndex == 0,
                onTap: () => ref.read(bottomNavIndexProvider.notifier).state = 0,
              ),
            ),
            Expanded(
              child: _BottomBarItem(
                icon: Icons.phone,
                label: 'Call',
                isActive: currentIndex == 3,
                onTap: () => ref.read(bottomNavIndexProvider.notifier).state = 3,
              ),
            ),
            Expanded(
              child: _BottomBarItem(
                icon: Icons.event,
                label: 'Book',
                isActive: currentIndex == 4,
                onTap: () => ref.read(bottomNavIndexProvider.notifier).state = 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _BottomBarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primary : AppColors.textLight,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
              color: isActive ? AppColors.primary : AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
