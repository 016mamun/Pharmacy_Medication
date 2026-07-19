import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';
import 'package:pharmacy_medication/features/home/providers/home_provider.dart';

class ContactScreen extends ConsumerWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Contact Us'),
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kersbrook Pharmacy',
                style: GoogleFonts.manrope(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your local Adelaide Hills pharmacy',
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(height: 32),

              _ContactInfoItem(
                icon: Icons.location_on,
                title: 'Address',
                content: '16 Scott St, Kersbrook SA 5231',
                onTap: () {},
              ),
              const SizedBox(height: 20),
              _ContactInfoItem(
                icon: Icons.phone,
                title: 'Phone',
                content: '08 8389 1205',
                onTap: () {},
              ),
              const SizedBox(height: 20),
              _ContactInfoItem(
                icon: Icons.email,
                title: 'Email',
                content: 'kersbrook@pharmacistadvice.com.au',
                onTap: () {},
              ),
              const SizedBox(height: 20),
              _ContactInfoItem(
                icon: Icons.access_time,
                title: 'Opening Hours',
                content: 'Mon-Fri: 9:00am - 6:00pm\nSat: 9:00am - 12:00pm\nSun: Closed',
                onTap: () {},
              ),

              const SizedBox(height: 40),
              Text(
                'Enquiry Form',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 16),
              const _EnquiryForm(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final VoidCallback onTap;

  const _ContactInfoItem({
    required this.icon,
    required this.title,
    required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                content,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: AppColors.textLight,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EnquiryForm extends StatefulWidget {
  const _EnquiryForm();

  @override
  State<_EnquiryForm> createState() => _EnquiryFormState();
}

class _EnquiryFormState extends State<_EnquiryForm> {
  String? _selectedType;
  final List<String> _enquiryTypes = [
    'General Enquiry',
    'Prescription Enquiry',
    'Delivery Enquiry',
    'Webster-pak Enquiry',
    'Vaccination Enquiry',
    'Feedback & Complaints',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextField(
          decoration: InputDecoration(labelText: 'Name'),
        ),
        const SizedBox(height: 16),
        const TextField(
          decoration: InputDecoration(labelText: 'Email'),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _selectedType,
          hint: Text(
            'Select Enquiry Type',
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: AppColors.textLight,
            ),
          ),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: _enquiryTypes.map((String type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(
                type,
                style: GoogleFonts.manrope(fontSize: 14),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedType = newValue;
            });
          },
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.textLight),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        const SizedBox(height: 16),
        const TextField(
          maxLines: 4,
          decoration: InputDecoration(labelText: 'Message'),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Thank you! Your enquiry has been sent.')),
              );
            },
            child: const Text('Send Enquiry'),
          ),
        ),
      ],
    );
  }
}
