import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmacy_medication/core/theme/app_colors.dart';
import 'package:pharmacy_medication/shared/widgets/app_network_image.dart';
import 'package:pharmacy_medication/features/health_advice/presentation/screens/health_advice_article_screen.dart';

class HealthAdviceScreen extends StatelessWidget {
  const HealthAdviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topics = [
      {'title': 'Children\'s Health', 'img': 'https://images.pexels.com/photos/1104007/pexels-photo-1104007.jpeg?auto=compress&cs=tinysrgb&w=300'},
      {'title': 'Women\'s Health', 'img': 'https://images.pexels.com/photos/3820202/pexels-photo-3820202.jpeg?auto=compress&cs=tinysrgb&w=300'},
      {'title': 'Men\'s Health', 'img': 'https://images.pexels.com/photos/3823488/pexels-photo-3823488.jpeg?auto=compress&cs=tinysrgb&w=300'},
      {'title': 'Healthy Ageing', 'img': 'https://images.pexels.com/photos/3768114/pexels-photo-3768114.jpeg?auto=compress&cs=tinysrgb&w=300'},
      {'title': 'Diabetes Care', 'img': 'https://images.pexels.com/photos/6823340/pexels-photo-6823340.jpeg?auto=compress&cs=tinysrgb&w=300'},
      {'title': 'Heart Health', 'img': 'https://images.pexels.com/photos/4386466/pexels-photo-4386466.jpeg?auto=compress&cs=tinysrgb&w=300'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Health Advice'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trustworthy Health Advice',
                style: GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textDark),
              ),
              const SizedBox(height: 8),
              Text(
                'Explore our pharmacist-reviewed health information hubs.',
                style: GoogleFonts.manrope(fontSize: 14, color: AppColors.textLight),
              ),
              const SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: topics.length,
                itemBuilder: (context, index) {
                  final topic = topics[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HealthAdviceArticleScreen(
                            title: topic['title'] as String,
                            imageUrl: topic['img'] as String,
                          ),
                        ),
                      );
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
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: AppNetworkImage(imageUrl: topic['img'] as String, fit: BoxFit.cover),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 12,
                            left: 12,
                            right: 12,
                            child: Text(
                              topic['title'] as String,
                              style: GoogleFonts.manrope(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              _buildSafetyNotice(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSafetyNotice() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
          const SizedBox(height: 12),
          Text(
            'Emergency Advice',
            style: GoogleFonts.manrope(fontWeight: FontWeight.w800, color: Colors.brown),
          ),
          const SizedBox(height: 8),
          Text(
            'This information is not suitable for emergencies. For urgent or severe symptoms, call 000 or seek immediate medical care.',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(fontSize: 12, color: Colors.brown),
          ),
        ],
      ),
    );
  }
}
