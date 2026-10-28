import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common/gold_button.dart';
import '../widgets/common/network_image_box.dart';
import '../widgets/common/section_header.dart';

class SpaSection extends StatelessWidget {
  final VoidCallback onEnquireSpa;

  const SpaSection({super.key, required this.onEnquireSpa});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
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
          child: Column(
            children: [
              SectionHeader(
                subtitle: 'SERENITY & REJUVENATION',
                title: 'Spa & Wellness Sanctuary',
                description:
                    'Step into an oasis of tranquility designed to dissolve fatigue and awaken inner balance through bespoke therapeutic treatments.',
                scale: isSmallMobile ? 0.75 : (isDesktop ? 1.0 : 0.85),
              ),
              const SizedBox(height: 52),

              isDesktop ? _buildDesktopLayout() : _buildMobileLayout(isSmallMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text Column
        Expanded(
          flex: 11,
          child: _buildTextContent(isCenter: false),
        ),
        const SizedBox(width: 70),

        // Visual Gallery / Composition
        Expanded(
          flex: 12,
          child: _buildImageComposition(height: 480),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(bool isSmallMobile) {
    return Column(
      children: [
        _buildImageComposition(height: isSmallMobile ? 260 : 340),
        const SizedBox(height: 36),
        _buildTextContent(isCenter: true),
      ],
    );
  }

  Widget _buildTextContent({required bool isCenter}) {
    return Column(
      crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'RESTORING MIND, BODY & SPIRIT',
          style: AppTypography.sans(
            color: AppColors.goldDark,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Harmonious Rituals of Complete Renewal',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: AppTypography.cardTitle(
            color: AppColors.forestGreenDark,
            scale: 1.15,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Our Spa & Wellness center offers a serene refuge from the rhythm of the city. Inspired by time-honored wellness philosophies, each therapy is tailored to nurture stillness, relieve tension, and restore vitality.',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: AppTypography.body(fontSize: 15, height: 1.7),
        ),
        const SizedBox(height: 14),
        Text(
          'Unwind in quiet consultation rooms, surround yourself with soothing botanical scents, and allow our skilled therapists to guide your path to holistic wellbeing.',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: AppTypography.body(
            color: AppColors.textMuted,
            fontSize: 14.5,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 28),

        // Wellness Features Row
        Wrap(
          spacing: 16,
          runSpacing: 10,
          alignment: isCenter ? WrapAlignment.center : WrapAlignment.start,
          children: const [
            _WellnessFeaturePill(icon: Icons.spa_outlined, label: 'Therapeutic Massages'),
            _WellnessFeaturePill(icon: Icons.water_drop_outlined, label: 'Aromatic Treatments'),
            _WellnessFeaturePill(icon: Icons.self_improvement_rounded, label: 'Relaxation Lounges'),
          ],
        ),
        const SizedBox(height: 32),

        LuxuryButton(
          label: 'Explore Spa & Wellness',
          type: LuxuryButtonType.darkFilled,
          onPressed: onEnquireSpa,
          icon: Icons.arrow_forward_rounded,
        ),
      ],
    );
  }

  Widget _buildImageComposition({required double height}) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const NetworkImageBox(
              imageUrl: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&w=1400&q=80',
              fit: BoxFit.cover,
              enableZoomOnHover: true,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.4),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.forestGreenDark.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.gold.withOpacity(0.35)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wb_sunny_outlined, color: AppColors.goldLight, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Calibrated calm for complete personal revival.',
                        style: AppTypography.sans(
                          color: AppColors.textOnDark,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WellnessFeaturePill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _WellnessFeaturePill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.creamBg,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.forestGreen),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTypography.sans(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: AppColors.textCharcoal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
