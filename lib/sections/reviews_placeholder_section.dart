import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common/section_header.dart';

class ReviewsPlaceholderSection extends StatelessWidget {
  const ReviewsPlaceholderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    final isSmallMobile = screenWidth < 380;

    return Container(
      color: AppColors.creamBg,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : 20,
        vertical: isDesktop ? 80 : 54,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              SectionHeader(
                subtitle: 'GUEST EXPERIENCES & FEEDBACK',
                title: 'Guest Reflections',
                description:
                    'We believe in genuine hospitality and verified customer feedback. Direct verified guest reviews will be integrated here upon official hospitality platform synchronization.',
                scale: isSmallMobile ? 0.75 : (isDesktop ? 1.0 : 0.85),
              ),
              const SizedBox(height: 36),

              // Elegant Verified Review Placeholder Card
              Container(
                padding: EdgeInsets.all(isDesktop ? 40 : 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.borderGold.withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Hospitality Laurel / Emblem
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.forestGreenDark.withOpacity(0.06),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.rate_review_outlined,
                        color: AppColors.goldDark,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 18),

                    Text(
                      'Dedicated to Hospitality Transparency',
                      textAlign: TextAlign.center,
                      style: AppTypography.serif(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.forestGreenDark,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Text(
                      'To maintain authentic standards, Ambal Rejency does not display unverified or fabricated testimonials. Verified guest reviews from Google and hospitality travel partners will appear in this carousel.',
                      textAlign: TextAlign.center,
                      style: AppTypography.body(
                        color: AppColors.textMuted,
                        fontSize: 14.5,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 16),

                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.gold)),
                          const SizedBox(width: 8),
                          Text(
                            'CONFIGURABLE REVIEW INTEGRATION READY',
                            style: AppTypography.sans(
                              color: AppColors.goldDark,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.gold)),
                        ],
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
  }
}
