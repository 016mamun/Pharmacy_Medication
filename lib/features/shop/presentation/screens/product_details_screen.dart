import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';
import 'package:pharmacy_medication/shared/models/product_model.dart';
import 'package:pharmacy_medication/shared/widgets/app_network_image.dart';
import 'package:pharmacy_medication/features/cart/providers/cart_provider.dart';
import 'package:pharmacy_medication/features/wishlist/providers/wishlist_provider.dart';
import 'package:pharmacy_medication/features/home/providers/home_provider.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isWishlisted = ref.watch(wishlistProvider).any((p) => p.id == product.id);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          product.name,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Share link copied')),
              );
            },
            icon: const Icon(Icons.share_outlined),
          ),
          IconButton(
            onPressed: () {
              ref.read(wishlistProvider.notifier).toggleWishlist(product);
              final nowWishlisted = ref.read(wishlistProvider).any((p) => p.id == product.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(nowWishlisted ? 'Added to wishlist' : 'Removed from wishlist'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            icon: Icon(
              isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: isWishlisted ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppNetworkImage(
              imageUrl: product.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          product.category,
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      if (product.type != ProductType.prescription)
                        Text(
                          '\$${product.price.toStringAsFixed(2)} AUD',
                          style: GoogleFonts.manrope(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.name,
                    style: GoogleFonts.manrope(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.unit,
                    style: GoogleFonts.manrope(fontSize: 14, color: AppColors.grey),
                  ),
                  const SizedBox(height: 24),
                  _buildTypeSpecificNotice(context, ref),
                  const SizedBox(height: 24),
                  _buildSection(
                    'Description',
                    product.description.isNotEmpty
                        ? product.description
                        : 'Professional quality pharmacy product. Please read instructions carefully before use.',
                  ),
                  _buildSection(
                    'Directions',
                    'Use only as directed. If symptoms persist, consult your healthcare professional.',
                  ),
                  _buildSection(
                    'Warnings',
                    'Keep out of reach of children. Store below 30°C. Read all packaging before use.',
                  ),
                  const SizedBox(height: 40),
                  _buildActionButton(context, ref),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, WidgetRef ref) {
    switch (product.type) {
      case ProductType.prescription:
        return SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton.icon(
            onPressed: () {
              // Navigate to Prescription Hub tab
              ref.read(bottomNavIndexProvider.notifier).state = 2;
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            icon: const Icon(Icons.medication),
            label: const Text('Go to Prescription Hub'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary, width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              textStyle: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        );
      case ProductType.pharmacistOnly:
        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(
                    'Pharmacist Review Required',
                    style: GoogleFonts.manrope(fontWeight: FontWeight.w800),
                  ),
                  content: Text(
                    'A pharmacist will contact you after your order is placed to confirm suitability before this item is dispatched.',
                    style: GoogleFonts.manrope(fontSize: 13, height: 1.5),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(cartProvider.notifier).addItem(product);
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Added — pharmacist review pending'),
                            backgroundColor: AppColors.primary,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                      child: const Text('Confirm & Add'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.lock_person),
            label: const Text('Request Pharmacist Review'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              textStyle: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        );
      default:
        // General & Pharmacy types — normal Add to Cart
        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () {
              ref.read(cartProvider.notifier).addItem(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} added to cart'),
                  backgroundColor: AppColors.primary,
                  action: SnackBarAction(
                    label: 'View Cart',
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined),
            label: const Text('Add to Cart'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              textStyle: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        );
    }
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textLight, height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeSpecificNotice(BuildContext context, WidgetRef ref) {
    switch (product.type) {
      case ProductType.general:
        return _buildPharmacistTipNotice();
      case ProductType.pharmacy:
        return _buildNoticeBox(
          icon: Icons.health_and_safety,
          title: 'Pharmacy Medicine (Schedule 2)',
          content:
              'This is a pharmacy-only product. By proceeding you confirm you have read the directions and warnings, and that it is appropriate for your use. If unsure, speak with a pharmacist.',
          bgColor: const Color(0xFFE8F4FD),
        );
      case ProductType.pharmacistOnly:
        return _buildNoticeBox(
          icon: Icons.lock_person,
          title: 'Pharmacist Only Medicine (Schedule 3)',
          content:
              'A pharmacist must speak with you before this medicine can be supplied. After you place your order, our pharmacist will contact you to confirm clinical suitability.',
          bgColor: const Color(0xFFFFF4E5),
        );
      case ProductType.prescription:
        return _buildNoticeBox(
          icon: Icons.receipt_long,
          title: 'Prescription Required (Schedule 4)',
          content:
              'A valid prescription from an Australian registered doctor is required for this medicine. Please use the Prescription Hub to submit your eScript or manage your prescription.',
          bgColor: const Color(0xFFF3E5F5),
        );
    }
  }

  Widget _buildNoticeBox({
    required IconData icon,
    required String title,
    required String content,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.manrope(fontSize: 12, color: AppColors.textLight, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildPharmacistTipNotice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.help_outline, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Need advice? Ask our Kersbrook pharmacist about this product before purchasing.',
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
