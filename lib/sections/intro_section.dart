import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common/gold_button.dart';
import '../widgets/common/network_image_box.dart';

class IntroSection extends StatelessWidget {
  final VoidCallback onDiscoverStory;

  const IntroSection({super.key, required this.onDiscoverStory});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    final isTablet = screenWidth >= 700 && screenWidth < 1024;
    final isSmallMobile = screenWidth < 380;

    return Container(
      color: AppColors.ivoryBg,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : (isTablet ? 36 : 20),
        vertical: isDesktop ? 100 : 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: isDesktop ? _buildDesktopLayout() : _buildStackedLayout(isSmallMobile),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Column: Editorial Text
        Expanded(
          flex: 11,
          child: _buildTextContent(isCenter: false, scale: 1.0),
        ),
        const SizedBox(width: 80),

        // Right Column: Layered Asymmetrical Images
        Expanded(
          flex: 12,
          child: _buildLayeredImages(height: 520),
        ),
      ],
    );
  }

  Widget _buildStackedLayout(bool isSmallMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTextContent(isCenter: true, scale: isSmallMobile ? 0.75 : 0.88),
        const SizedBox(height: 48),
        _buildLayeredImages(height: 380),
      ],
    );
  }

  Widget _buildTextContent({required bool isCenter, required double scale}) {
    return Column(
      crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Subtitle
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 20, height: 1.5, color: AppColors.goldDark),
              const SizedBox(width: 10),
              Text(
                'A SANCTUARY OF HOSPITABLE GRACE',
                style: AppTypography.sectionSubtitle(color: AppColors.goldDark),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Main Serif Heading
        Text(
          'Crafted for Relaxation, Celebrated for Hospitality.',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: AppTypography.sectionTitle(
            color: AppColors.forestGreenDark,
            scale: scale,
          ),
        ),
        const SizedBox(height: 22),

        // Editorial Narrative
        Text(
          'Rooted in the venerable traditions of warm Indian hospitality, Ambal Rejency was envisioned as a tranquil haven where modern comfort aligns seamlessly with gracious personal attention.',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: AppTypography.body(
            color: AppColors.textCharcoal,
            fontSize: 16,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'From our climate-controlled AC Deluxe Rooms to the culinary finesse of our restaurant, the serene indulgence of our wellness sanctuary, and the vibrant ambiance of our bar, every detail is considered to enrich your journey.',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: AppTypography.body(
            color: AppColors.textMuted,
            fontSize: 15,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 32),

        // Discover Action
        LuxuryButton(
          label: 'Discover Our Story',
          type: LuxuryButtonType.darkFilled,
          onPressed: onDiscoverStory,
          icon: Icons.arrow_forward_rounded,
        ),
      ],
    );
  }

  Widget _buildLayeredImages({required double height}) {
    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Subtle Gold Decorative Frame
          Positioned(
            top: 20,
            left: 20,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.gold.withOpacity(0.4), width: 1.5),
              ),
            ),
          ),

          // Primary Large Architectural Photo
          Positioned(
            top: 0,
            left: 0,
            right: 40,
            bottom: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const NetworkImageBox(
                imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=1200&q=80',
                fit: BoxFit.cover,
                enableZoomOnHover: true,
              ),
            ),
          ),

          // Secondary Overlapping Supporting Photo (Lower Right)
          Positioned(
            right: 0,
            bottom: 0,
            width: height * 0.52,
            height: height * 0.52,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.ivoryBg, width: 6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 24,
                    offset: const Offset(4, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: const NetworkImageBox(
                  imageUrl: 'https://images.unsplash.com/photo-1590381105924-c72589b9ef3f?auto=format&fit=crop&w=1000&q=80',
                  fit: BoxFit.cover,
                  enableZoomOnHover: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
