import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common/gold_button.dart';
import '../widgets/common/network_image_box.dart';
import '../widgets/common/section_header.dart';

class BanquetSection extends StatefulWidget {
  final VoidCallback onEnquireEvents;

  const BanquetSection({super.key, required this.onEnquireEvents});

  @override
  State<BanquetSection> createState() => _BanquetSectionState();
}

class _BanquetSectionState extends State<BanquetSection> {
  int _activeSlide = 0;

  static const List<Map<String, String>> banquetSlides = [
    {
      'title': 'Grand Banquet Hall',
      'url': 'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?auto=format&fit=crop&w=1400&q=80',
      'caption': 'Expansive ballroom with majestic ceiling heights and ambient chandelier glow.',
    },
    {
      'title': 'Bespoke Celebration Decor',
      'url': 'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?auto=format&fit=crop&w=1200&q=80',
      'caption': 'Configurable seating arrangements tailored for personal milestones and banquets.',
    },
    {
      'title': 'Event Lighting & Staging',
      'url': 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?auto=format&fit=crop&w=1200&q=80',
      'caption': 'Professional ambiance and attentive staff ensuring smooth occasion execution.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isSmallMobile = screenWidth < 380;

    return Container(
      color: AppColors.creamBg,
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
                subtitle: 'GATHERINGS & MILESTONES',
                title: 'The Banquet Hall at Ambal Rejency',
                description:
                    'An inspiring venue designed to host momentous celebrations, formal receptions, and executive gatherings with effortless grace.',
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
    final current = banquetSlides[_activeSlide];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Column: Main Interactive Image Showcase
        Expanded(
          flex: 12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 440,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 400),
                        child: NetworkImageBox(
                          key: ValueKey(_activeSlide),
                          imageUrl: current['url']!,
                          fit: BoxFit.cover,
                          enableZoomOnHover: true,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          color: Colors.black.withOpacity(0.65),
                          child: Text(
                            current['caption']!,
                            style: AppTypography.sans(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Slide Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(banquetSlides.length, (index) {
                  final isSelected = _activeSlide == index;
                  return GestureDetector(
                    onTap: () => setState(() => _activeSlide = index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: isSelected ? 32 : 10,
                      height: 5,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.gold : AppColors.borderLight,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        const SizedBox(width: 60),

        // Right Column: Text & Event Details
        Expanded(
          flex: 11,
          child: _buildTextContent(isCenter: false),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(bool isSmallMobile) {
    final current = banquetSlides[_activeSlide];

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: isSmallMobile ? 240 : 320,
            child: NetworkImageBox(
              imageUrl: current['url']!,
              fit: BoxFit.cover,
              enableZoomOnHover: true,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banquetSlides.length, (index) {
            final isSelected = _activeSlide == index;
            return GestureDetector(
              onTap: () => setState(() => _activeSlide = index),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isSelected ? 24 : 8,
                height: 4,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.gold : AppColors.borderLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 32),
        _buildTextContent(isCenter: true),
      ],
    );
  }

  Widget _buildTextContent({required bool isCenter}) {
    return Column(
      crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'WHERE MOMENTS BECOME MEMORIES',
          style: AppTypography.sans(
            color: AppColors.goldDark,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'A Distinguished Stage for Cherished Occasions',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: AppTypography.cardTitle(
            color: AppColors.forestGreenDark,
            scale: 1.15,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Ambal Rejency’s Banquet Hall is designed to elevate your special events. Featuring generous floor plans, refined acoustic qualities, and sophisticated lighting, the venue provides an adaptable canvas.',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: AppTypography.body(fontSize: 15, height: 1.7),
        ),
        const SizedBox(height: 14),
        Text(
          'Our hospitality team is committed to assisting you at every stage, ensuring seamless event coordination, tailored culinary offerings, and unforgettable guest comfort.',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: AppTypography.body(
            color: AppColors.textMuted,
            fontSize: 14.5,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 28),

        // Action CTA
        LuxuryButton(
          label: 'Enquire About Events',
          onPressed: widget.onEnquireEvents,
          icon: Icons.celebration_outlined,
        ),
      ],
    );
  }
}

