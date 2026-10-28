import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common/gold_button.dart';
import '../widgets/common/network_image_box.dart';
import '../widgets/common/section_header.dart';

class RestaurantSection extends StatefulWidget {
  final VoidCallback onReserveTable;
  final VoidCallback onExploreMenu;

  const RestaurantSection({
    super.key,
    required this.onReserveTable,
    required this.onExploreMenu,
  });

  @override
  State<RestaurantSection> createState() => _RestaurantSectionState();
}

class _RestaurantSectionState extends State<RestaurantSection> {
  int _activeGalleryIndex = 0;

  static const List<Map<String, String>> restaurantGallery = [
    {
      'title': 'The Dining Room',
      'url': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=1200&q=80',
      'caption': 'Warm golden ambient lighting and attentive, discreet service.',
    },
    {
      'title': 'Gastronomic Artistry',
      'url': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=1200&q=80',
      'caption': 'Thoughtfully composed dishes balancing authentic spices and modern presentation.',
    },
    {
      'title': 'Intimate Dining Alcoves',
      'url': 'https://images.unsplash.com/photo-1550966871-3ed3cdb5ed0c?auto=format&fit=crop&w=1200&q=80',
      'caption': 'Spacious seating for family celebrations and executive dinners.',
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
                subtitle: 'FINE DINING & CULINARY EXCELLENCE',
                title: 'A Taste Worth Remembering',
                description:
                    'Immerse your palate in an epicurean journey where culinary craft meets heartwarming hospitality in a beautifully orchestrated setting.',
                scale: isSmallMobile ? 0.75 : (isDesktop ? 1.0 : 0.85),
              ),
              const SizedBox(height: 52),

              // Main Editorial Showcase
              isDesktop ? _buildDesktopLayout() : _buildMobileLayout(isSmallMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    final currentItem = restaurantGallery[_activeGalleryIndex];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Column: Interactive Culinary Showcase
        Expanded(
          flex: 12,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 440,
                  width: double.infinity,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: NetworkImageBox(
                      key: ValueKey(_activeGalleryIndex),
                      imageUrl: currentItem['url']!,
                      fit: BoxFit.cover,
                      enableZoomOnHover: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Thumbnails Selector
              Row(
                children: List.generate(restaurantGallery.length, (index) {
                  final item = restaurantGallery[index];
                  final isSelected = _activeGalleryIndex == index;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index < restaurantGallery.length - 1 ? 12 : 0),
                      child: InkWell(
                        onTap: () => setState(() => _activeGalleryIndex = index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected ? AppColors.gold : Colors.transparent,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: SizedBox(
                              height: 64,
                              child: NetworkImageBox(
                                imageUrl: item['url']!,
                                fit: BoxFit.cover,
                              ),
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
        const SizedBox(width: 60),

        // Right Column: Text & CTAs
        Expanded(
          flex: 11,
          child: _buildTextContent(isCenter: false),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(bool isSmallMobile) {
    final currentItem = restaurantGallery[_activeGalleryIndex];

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: isSmallMobile ? 240 : 320,
            width: double.infinity,
            child: NetworkImageBox(
              imageUrl: currentItem['url']!,
              fit: BoxFit.cover,
              enableZoomOnHover: true,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Thumbnails
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(restaurantGallery.length, (index) {
            final isSelected = _activeGalleryIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _activeGalleryIndex = index),
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
          'AN INVITATION TO FEAST',
          style: AppTypography.sans(
            color: AppColors.goldDark,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Flavors Celebrated in Elegance',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: AppTypography.cardTitle(
            color: AppColors.forestGreenDark,
            scale: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'At Ambal Rejency, dining is elevated to an art form. Our culinary team blends traditional spice mastery with contemporary culinary finesse, crafting memorable dining experiences for every palate.',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: AppTypography.body(fontSize: 15, height: 1.7),
        ),
        const SizedBox(height: 14),
        Text(
          'Whether you are gathering for an energizing morning breakfast, an executive business luncheon, or a lingering candlelit dinner with family, our restaurant offers the perfect ambiance.',
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: AppTypography.body(
            color: AppColors.textMuted,
            fontSize: 14.5,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 28),

        // Action Buttons
        Wrap(
          spacing: 14,
          runSpacing: 12,
          alignment: isCenter ? WrapAlignment.center : WrapAlignment.start,
          children: [
            LuxuryButton(
              label: 'Contact for Reservations',
              onPressed: widget.onReserveTable,
              icon: Icons.table_restaurant_outlined,
            ),
            LuxuryButton(
              label: 'Explore Our Restaurant',
              type: LuxuryButtonType.goldOutline,
              onPressed: widget.onExploreMenu,
            ),
          ],
        ),
      ],
    );
  }
}

