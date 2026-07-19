import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';
import 'package:pharmacy_medication/features/cart/providers/cart_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  int _currentStep = 0;
  String _selectedDelivery = 'standard';
  bool _pharmacistAcknowledged = false;
  bool _privacyConsent = false;

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _suburbController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _suburbController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final subtotal = ref.watch(cartSubtotalProvider);
    final discount = ref.watch(discountProvider);
    final deliveryFee = _selectedDelivery == 'collect'
        ? 0.0
        : _selectedDelivery == 'express'
            ? 14.95
            : deliveryCharge;
    final total = subtotal - discount + deliveryFee;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text(
                    _currentStep == 3 ? 'Place Order' : 'Continue',
                    style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
                  ),
                ),
                if (_currentStep > 0)
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text('Back'),
                  ),
              ],
            ),
          );
        },
        onStepContinue: () {
          if (_currentStep == 3) {
            if (!_privacyConsent) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please confirm your privacy consent to continue.')),
              );
              return;
            }
            _showOrderSuccess();
          } else {
            if (_currentStep < 3) setState(() => _currentStep++);
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) setState(() => _currentStep--);
        },
        onStepTapped: (step) => setState(() => _currentStep = step),
        steps: [
          // Step 1: Delivery Details
          Step(
            title: Text(
              'Delivery Details',
              style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField('Full Name', _nameController, Icons.person),
                const SizedBox(height: 12),
                _buildTextField('Street Address', _addressController, Icons.home),
                const SizedBox(height: 12),
                _buildTextField('Suburb / State / Postcode', _suburbController, Icons.location_city),
                const SizedBox(height: 12),
                _buildTextField('Email Address', _emailController, Icons.email),
              ],
            ),
            isActive: _currentStep >= 0,
          ),

          // Step 2: Delivery Method
          Step(
            title: Text(
              'Delivery Method',
              style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
            ),
            content: Column(
              children: [
                _buildDeliveryOption(
                  value: 'collect',
                  title: 'Click & Collect',
                  subtitle: '16 Scott St, Kersbrook SA 5231\nMon–Fri 9am–6pm, Sat 9am–12pm',
                  price: 'Free',
                  icon: Icons.store,
                ),
                const SizedBox(height: 12),
                _buildDeliveryOption(
                  value: 'standard',
                  title: 'Standard Post',
                  subtitle: 'Australia Post — approx. 2–5 business days',
                  price: '\$${deliveryCharge.toStringAsFixed(2)} AUD',
                  icon: Icons.local_shipping,
                ),
                const SizedBox(height: 12),
                _buildDeliveryOption(
                  value: 'express',
                  title: 'Express Post',
                  subtitle: 'Australia Post — approx. 1–2 business days',
                  price: '\$14.95 AUD',
                  icon: Icons.delivery_dining,
                ),
                const SizedBox(height: 16),
                // Cold chain / Restricted notice
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.amber.shade200),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline, color: Colors.amber, size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Some items may have delivery restrictions (e.g. refrigerated medicines, restricted Schedule items). Our pharmacist will confirm any limitations before dispatch.',
                          style: GoogleFonts.manrope(fontSize: 11, color: Colors.brown),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            isActive: _currentStep >= 1,
          ),

          // Step 3: Pharmacist Acknowledgement
          Step(
            title: Text(
              'Pharmacist Review',
              style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Confirmation Required',
                  style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary),
                ),
                const SizedBox(height: 12),
                Text(
                  'Before your order is dispensed, a Kersbrook pharmacist will review your order to confirm clinical suitability, stock availability and delivery eligibility. This is required by Australian pharmacy law.',
                  style: GoogleFonts.manrope(fontSize: 13, color: AppColors.textLight, height: 1.5),
                ),
                const SizedBox(height: 20),
                _buildAcknowledgeCheckbox(
                  'I understand a pharmacist will review my order before dispatch.',
                  _pharmacistAcknowledged,
                  (val) => setState(() => _pharmacistAcknowledged = val ?? false),
                ),
                const SizedBox(height: 8),
                // Order summary
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Summary',
                        style: GoogleFonts.manrope(fontWeight: FontWeight.w800, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      ...cartItems.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${item.product.name} ×${item.quantity}',
                                style: GoogleFonts.manrope(fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '\$${item.totalPrice.toStringAsFixed(2)}',
                              style: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      )),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total incl. delivery', style: GoogleFonts.manrope(fontWeight: FontWeight.w800)),
                          Text(
                            '\$${total.toStringAsFixed(2)} AUD',
                            style: GoogleFonts.manrope(fontWeight: FontWeight.w900, color: AppColors.primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            isActive: _currentStep >= 2,
          ),

          // Step 4: Secure Payment
          Step(
            title: Text(
              'Secure Payment',
              style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Payment security notice — CRITICAL compliance
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.lock, color: Colors.green.shade700, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Card details are never stored by Kersbrook Pharmacy. Payment is processed securely by our PCI-compliant payment provider.',
                          style: GoogleFonts.manrope(
                            fontSize: 12,
                            color: Colors.green.shade800,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'You will be securely redirected to our payment provider to complete your purchase.',
                  style: GoogleFonts.manrope(fontSize: 13, color: AppColors.textLight, height: 1.5),
                ),
                const SizedBox(height: 20),
                // Payment method icons row
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildPaymentBadge('Visa'),
                    _buildPaymentBadge('Mastercard'),
                    _buildPaymentBadge('PayPal'),
                    _buildPaymentBadge('AfterPay'),
                  ],
                ),
                const SizedBox(height: 24),
                _buildAcknowledgeCheckbox(
                  'I agree to the Terms of Service and Privacy Policy and confirm my order details are correct.',
                  _privacyConsent,
                  (val) => setState(() => _privacyConsent = val ?? false),
                ),
              ],
            ),
            isActive: _currentStep >= 3,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20, color: AppColors.primary),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildDeliveryOption({
    required String value,
    required String title,
    required String subtitle,
    required String price,
    required IconData icon,
  }) {
    final isSelected = _selectedDelivery == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedDelivery = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.inputBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.grey, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: isSelected ? AppColors.primary : AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.manrope(fontSize: 11, color: AppColors.textLight, height: 1.4),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      color: isSelected ? AppColors.primary : AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primary, size: 20)
            else
              const Icon(Icons.radio_button_unchecked, color: AppColors.grey, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAcknowledgeCheckbox(String label, bool value, Function(bool?) onChanged) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!value),
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                label,
                style: GoogleFonts.manrope(fontSize: 13, color: AppColors.textDark, height: 1.4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Text(
        label,
        style: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textDark),
      ),
    );
  }

  void _showOrderSuccess() {
    ref.read(cartProvider.notifier).clearCart();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle, color: AppColors.primary, size: 36),
            ),
            const SizedBox(height: 20),
            Text(
              'Order Received',
              style: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textDark),
            ),
            const SizedBox(height: 12),
            Text(
              'Thank you! Your order is now in our pharmacist review queue. We will contact you shortly to confirm and process your order.',
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(fontSize: 13, color: AppColors.textLight, height: 1.5),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
              child: Text(
                'Return to Home',
                style: GoogleFonts.manrope(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
