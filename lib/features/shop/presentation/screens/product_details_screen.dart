import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';
import 'package:pharmacy_medication/shared/models/product_model.dart';
import 'package:pharmacy_medication/shared/widgets/app_network_image.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(product.name),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Text(
                        '${product.price.toStringAsFixed(2)} AUD',
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
                  _buildTypeSpecificNotice(context),
                  const SizedBox(height: 24),
                  _buildSection('Description', product.description.isNotEmpty ? product.description : 'Professional quality pharmacy product. Please read instructions carefully.'),
                  _buildSection('Directions', 'Use only as directed. If symptoms persist consult your healthcare professional.'),
                  _buildSection('Warnings', 'Keep out of reach of children. Store below 30°C.'),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: product.type == ProductType.prescription ? null : () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: product.type == ProductType.pharmacistOnly ? Colors.orange : AppColors.primary,
                      ),
                      child: Text(
                        product.type == ProductType.prescription 
                          ? 'Prescription Only' 
                          : product.type == ProductType.pharmacistOnly 
                            ? 'Request Pharmacist Review' 
                            : 'Add to Cart'
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.textDark),
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

  Widget _buildTypeSpecificNotice(BuildContext context) {
    if (product.type == ProductType.general) {
      return _buildPharmacistNotice();
    }

    String title = '';
    String content = '';
    Color bgColor = AppColors.primaryLight;
    IconData icon = Icons.info_outline;

    switch (product.type) {
      case ProductType.pharmacy:
        title = 'Pharmacy Medicine';
        content = 'This product requires pharmacist review before supply. Please confirm you have read the directions and warnings.';
        bgColor = const Color(0xFFE8F4FD);
        icon = Icons.health_and_safety;
        break;
      case ProductType.pharmacistOnly:
        title = 'Pharmacist Only Medicine';
        content = 'A pharmacist must speak with you before this product can be supplied. We will contact you after order placement.';
        bgColor = const Color(0xFFFFF4E5);
        icon = Icons.lock_person;
        break;
      case ProductType.prescription:
        title = 'Prescription Required';
        content = 'A valid prescription from an Australian doctor is required. Please upload your eScript or manage through the Prescription Hub.';
        bgColor = const Color(0xFFF3E5F5);
        icon = Icons.receipt;
        break;
      default:
        return _buildPharmacistNotice();
    }

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
              Text(
                title,
                style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.manrope(fontSize: 12, color: AppColors.textLight, height: 1.5),
          ),
          if (product.type == ProductType.prescription) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  // Direct to prescription hub
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Redirecting to Prescription Hub...')));
                },
                child: const Text('Go to Prescription Hub'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPharmacistNotice() {
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
              'Need advice? Ask our Kersbrook pharmacist about this product.',
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
