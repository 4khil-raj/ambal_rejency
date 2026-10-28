import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../common/brand_logo.dart';
import '../common/gold_button.dart';

class PremiumNavBar extends StatelessWidget {
  final bool isScrolled;
  final Function(int index) onNavItemSelected;
  final VoidCallback onBookStayPressed;
  final VoidCallback onOpenMobileMenu;
  final int activeIndex;

  const PremiumNavBar({
    super.key,
    required this.isScrolled,
    required this.onNavItemSelected,
    required this.onBookStayPressed,
    required this.onOpenMobileMenu,
    this.activeIndex = 0,
  });

  static const List<String> navLabels = [
    'Home',
    'Rooms & Suites',
    'Restaurant',
    'Spa & Wellness',
    'Banquet Hall',
    'AC Bar',
    'Gallery',
    'Contact',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1240;
    final isMobile = screenWidth < 768;
    final isSmallMobile = screenWidth < 420;

    final double logoScale = (isScrolled ? 0.92 : 1.0) *
        (isSmallMobile ? 0.68 : (isMobile ? 0.82 : (isDesktop ? 1.0 : 0.92)));

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: isScrolled ? 74 : (isSmallMobile ? 76 : 90),
      decoration: BoxDecoration(
        color: isScrolled
            ? AppColors.forestGreenDark.withValues(alpha: 0.96)
            : const Color(0x990A1A14),
        border: Border(
          bottom: BorderSide(
            color: isScrolled
                ? AppColors.gold.withValues(alpha: 0.25)
                : Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1440),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 36 : (isSmallMobile ? 12 : 20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Brand Logo
                Flexible(
                  flex: 0,
                  child: BrandLogo(
                    isLight: true,
                    scale: logoScale,
                    onTap: () => onNavItemSelected(0),
                  ),
                ),

                // Desktop Navigation Items
                if (isDesktop)
                  Expanded(
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (int i = 0; i < navLabels.length; i++)
                              _DesktopNavItem(
                                label: navLabels[i],
                                isActive: activeIndex == i,
                                onTap: () => onNavItemSelected(i),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),

                // Right Actions: CTA & Mobile Drawer Toggle
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isDesktop)
                      LuxuryButton(
                        label: 'Book a Stay',
                        onPressed: onBookStayPressed,
                        icon: Icons.calendar_month_outlined,
                      )
                    else if (!isSmallMobile && screenWidth >= 480)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: LuxuryButton(
                          label: 'Book',
                          fontSize: 11,
                          customPaddingH: 14,
                          customPaddingV: 10,
                          onPressed: onBookStayPressed,
                        ),
                      ),

                    if (!isDesktop)
                      IconButton(
                        icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 26),
                        tooltip: 'Open Menu',
                        onPressed: onOpenMobileMenu,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopNavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _DesktopNavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_DesktopNavItem> createState() => _DesktopNavItemState();
}

class _DesktopNavItemState extends State<_DesktopNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isHighlight = widget.isActive || _isHovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTypography.sans(
                  color: isHighlight ? AppColors.goldLight : Colors.white.withValues(alpha: 0.9),
                  fontSize: 13,
                  fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w500,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: isHighlight ? 20 : 0,
                color: AppColors.gold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
