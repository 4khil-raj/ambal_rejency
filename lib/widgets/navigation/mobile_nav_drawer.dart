import 'package:flutter/material.dart';
import '../../models/hotel_config.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../common/brand_logo.dart';
import '../common/gold_button.dart';

class MobileNavDrawer extends StatelessWidget {
  final Function(int index) onNavItemSelected;
  final VoidCallback onBookStayPressed;
  final int activeIndex;

  const MobileNavDrawer({
    super.key,
    required this.onNavItemSelected,
    required this.onBookStayPressed,
    this.activeIndex = 0,
  });

  static const List<Map<String, dynamic>> menuItems = [
    {'title': 'Home', 'icon': Icons.home_outlined},
    {'title': 'Rooms & Suites', 'icon': Icons.king_bed_outlined},
    {'title': 'Restaurant', 'icon': Icons.restaurant_outlined},
    {'title': 'Spa & Wellness', 'icon': Icons.spa_outlined},
    {'title': 'Banquet Hall', 'icon': Icons.celebration_outlined},
    {'title': 'AC Bar', 'icon': Icons.wine_bar_outlined},
    {'title': 'Gallery', 'icon': Icons.photo_library_outlined},
    {'title': 'Contact', 'icon': Icons.location_on_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.forestGreenDark,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drawer Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 16, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BrandLogo(isLight: true, scale: 0.95),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white, size: 26),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.borderDark),

            // Navigation Items List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  final isCurrent = activeIndex == index;

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                    leading: Icon(
                      item['icon'] as IconData,
                      color: isCurrent ? AppColors.goldLight : Colors.white70,
                      size: 22,
                    ),
                    title: Text(
                      item['title'] as String,
                      style: AppTypography.sans(
                        color: isCurrent ? AppColors.goldLight : Colors.white,
                        fontSize: 15,
                        fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                        letterSpacing: 0.8,
                      ),
                    ),
                    trailing: isCurrent
                        ? Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.gold,
                            ),
                          )
                        : null,
                    onTap: () {
                      Navigator.of(context).pop();
                      onNavItemSelected(index);
                    },
                  );
                },
              ),
            ),

            // Bottom CTA & Contact info
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFF071711),
                border: Border(top: BorderSide(color: AppColors.borderDark)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LuxuryButton(
                    label: 'Book a Stay',
                    isFullWidth: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                      onBookStayPressed();
                    },
                    icon: Icons.calendar_month_outlined,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      HotelConfig.contactEmail,
                      style: AppTypography.sans(
                        color: AppColors.textOnDarkMuted,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

