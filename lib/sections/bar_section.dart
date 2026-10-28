import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common/gold_button.dart';
import '../widgets/common/network_image_box.dart';
import '../widgets/common/section_header.dart';

class BarSection extends StatefulWidget {
  final VoidCallback onExploreBar;
  final VoidCallback onContactHotel;

  const BarSection({
    super.key,
    required this.onExploreBar,
    required this.onContactHotel,
  });

  @override
  State<BarSection> createState() => _BarSectionState();
}

class _BarSectionState extends State<BarSection> {
  int _activeBarImage = 0;

  static const List<Map<String, String>> barImages = [
    {
      'title': 'The Bar Counter & Lounge',
      'url': 'https://images.unsplash.com/photo-1572116469696-31de0f17cc34?auto=format&fit=crop&w=1400&q=80',
      'caption': 'Subdued ambient glow, premium spirit collections, and plush bar-side seating.',
    },
    {
      'title': 'Intimate Leather Booths',
      'url': 'https://images.unsplash.com/photo-1514933651103-005eec06c04b?auto=format&fit=crop&w=1200&q=80',
      'caption': 'Private lounge corners ideal for conversation and relaxed evening unwinding.',
    },
    {
      'title': 'Curated Spirits & Mixology',
      'url': 'https://images.unsplash.com/photo-1578683010236-d716f9a3f461?auto=format&fit=crop&w=1200&q=80',
      'caption': 'Refined glassware and crafted refreshments served in an air-conditioned retreat.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isSmallMobile = screenWidth < 380;

    return Container(
      color: AppColors.barBackground,
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
                subtitle: 'NIGHTCAPS & CONVERSATION',
                title: 'The Atmospheric AC Bar',
                description:
                    'An intimate evening retreat featuring subdued lighting, refined refreshment selections, and climate-controlled relaxation.',
                isDark: true,
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
    final current = barImages[_activeBarImage];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Column: Text & Features
        Expanded(
          flex: 11,
          child: _buildTextContent(isCenter: false),
        ),
        const SizedBox(width: 70),

        // Right Column: Dark Cinematic Showcase
        Expanded(
          flex: 12,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.barBorder),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 440,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: NetworkImageBox(
                            key: ValueKey(_activeBarImage),
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
                            color: Colors.black.withOpacity(0.75),
                            child: Text(
                              current['caption']!,
                              style: AppTypography.sans(
                                color: AppColors.textOnDarkMuted,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Selector Tabs
              Row(
                children: List.generate(barImages.length, (index) {
                  final isSelected = _activeBarImage == index;
                  final item = barImages[index];

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index < barImages.length - 1 ? 12 : 0),
                      child: InkWell(
                        onTap: () => setState(() => _activeBarImage = index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected ? AppColors.barAmber : AppColors.barBorder,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: SizedBox(
                              height: 60,
                              child: NetworkImageBox(imageUrl: item['url']!, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(bool isSmallMobile) {
    final current = barImages[_activeBarImage];

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: isSmallMobile ? 240 : 320,
            width: double.infinity,
            child: NetworkImageBox(
              imageUrl: current['url']!,
              fit: BoxFit.cover,
              enableZoomOnHover: true,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(barImages.length, (index) {
            final isSelected = _activeBarImage == index;
            return GestureDetector(
              onTap: () => setState(() => _activeBarImage = index),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isSelected ? 24 : 8,
                height: 4,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.barAmber : AppColors.barBorder,
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
          'AN INTIMATE EVENING ESCAPE',
          style: AppTypography.sans(
            color: AppColors.barAmber,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Sophisticated Evenings in Cool Comfort',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: AppTypography.cardTitle(
            color: AppColors.textOnDark,
            scale: 1.15,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'When day turns to dusk, Ambal Rejency’s AC Bar welcomes guests into a tastefully designed space characterized by rich wood paneling, warm amber illumination, and effortless hospitality.',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: AppTypography.body(
            color: AppColors.textOnDarkMuted,
            fontSize: 15,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Whether reconnecting with business colleagues or sharing an easy evening with friends, enjoy a tranquil, air-conditioned environment complemented by courteous service.',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: AppTypography.body(
            color: AppColors.textOnDarkMuted.withOpacity(0.85),
            fontSize: 14.5,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 32),

        // Action Buttons
        Wrap(
          spacing: 14,
          runSpacing: 12,
          alignment: isCenter ? WrapAlignment.center : WrapAlignment.start,
          children: [
            LuxuryButton(
              label: 'Explore the Bar',
              onPressed: widget.onExploreBar,
              icon: Icons.wine_bar_outlined,
            ),
            LuxuryButton(
              label: 'Contact Hotel',
              type: LuxuryButtonType.goldOutline,
              onPressed: widget.onContactHotel,
            ),
          ],
        ),
      ],
    );
  }
}

