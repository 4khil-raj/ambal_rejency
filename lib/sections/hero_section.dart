import 'dart:async';
import 'package:flutter/material.dart';
import '../data/hotel_data.dart';
import '../models/hotel_config.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common/gold_button.dart';
import '../widgets/common/network_image_box.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onExploreRooms;
  final VoidCallback onDiscoverExperiences;
  final VoidCallback onScrollDown;

  const HeroSection({
    super.key,
    required this.onExploreRooms,
    required this.onDiscoverExperiences,
    required this.onScrollDown,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  int _activeSlide = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoplay();
  }

  void _startAutoplay() {
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (mounted) {
        setState(() {
          _activeSlide = (_activeSlide + 1) % HotelData.heroSlides.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _setSlide(int index) {
    setState(() => _activeSlide = index);
    _timer?.cancel();
    _startAutoplay();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isSmallMobile = screenWidth < 380;

    // Minimum sensible height for luxury hero
    final heroHeight = screenHeight.clamp(580.0, 920.0);

    return SizedBox(
      height: heroHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Carousel with Crossfade
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
            child: SizedBox(
              key: ValueKey(_activeSlide),
              height: heroHeight,
              width: double.infinity,
              child: NetworkImageBox(
                imageUrl: HotelData.heroSlides[_activeSlide].imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Cinematic Vignette and Dark Gradient Overlays
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.55),
                  Colors.black.withOpacity(0.35),
                  Colors.black.withOpacity(0.85),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Subtle radial vignette
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.1,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.4),
                ],
              ),
            ),
          ),

          // Hero Foreground Content
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 48,
                vertical: isMobile ? 24 : 40,
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: isSmallMobile ? 20 : 40),

                      // Brand Subtitle / Monogram
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(width: 28, height: 1.5, color: AppColors.gold),
                            const SizedBox(width: 12),
                            Text(
                              'WELCOME TO AMBAL REJENCY',
                              style: AppTypography.sans(
                                color: AppColors.goldLight,
                                fontSize: isSmallMobile ? 10.5 : 12.5,
                                fontWeight: FontWeight.w600,
                                letterSpacing: isSmallMobile ? 2.5 : 4.0,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(width: 28, height: 1.5, color: AppColors.gold),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Editorial Main Heading
                      Text(
                        HotelConfig.heroTagline,
                        textAlign: TextAlign.center,
                        style: AppTypography.heroTitle(
                          scale: isMobile ? (isSmallMobile ? 0.58 : 0.68) : 1.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Elegant Hospitality Description
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 720),
                        child: Text(
                          HotelConfig.heroDescription,
                          textAlign: TextAlign.center,
                          style: AppTypography.body(
                            color: Colors.white.withValues(alpha: 0.88),
                            fontSize: isMobile ? 14 : 16.5,
                            height: 1.65,
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),

                      // Call To Action Buttons
                      Wrap(
                        spacing: 16,
                        runSpacing: 14,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          LuxuryButton(
                            label: 'Explore Our Rooms',
                            onPressed: widget.onExploreRooms,
                            icon: Icons.arrow_forward_rounded,
                          ),
                          LuxuryButton(
                            label: 'Discover Experiences',
                            type: LuxuryButtonType.goldOutline,
                            onPressed: widget.onDiscoverExperiences,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Slide Indicator Dots & Captions
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Carousel Indicators
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(HotelData.heroSlides.length, (index) {
                    final isCurrent = _activeSlide == index;
                    return GestureDetector(
                      onTap: () => _setSlide(index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isCurrent ? 28 : 8,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isCurrent ? AppColors.gold : Colors.white38,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),

                // Subtle Scroll Indicator
                if (!isMobile)
                  GestureDetector(
                    onTap: widget.onScrollDown,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'SCROLL TO EXPLORE',
                            style: AppTypography.sans(
                              color: AppColors.goldLight,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2.5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.gold,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
