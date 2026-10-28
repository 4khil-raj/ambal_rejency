import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common/network_image_box.dart';
import '../widgets/common/section_header.dart';

class ExperienceCardItem {
  final String title;
  final String tag;
  final String description;
  final String imageUrl;
  final int sectionIndex;

  const ExperienceCardItem({
    required this.title,
    required this.tag,
    required this.description,
    required this.imageUrl,
    required this.sectionIndex,
  });
}

class ExperiencesSection extends StatelessWidget {
  final Function(int targetSectionIndex) onSelectExperience;

  const ExperiencesSection({super.key, required this.onSelectExperience});

  static const List<ExperienceCardItem> experiences = [
    ExperienceCardItem(
      title: 'AC Deluxe Rooms',
      tag: 'ACCOMMODATION',
      description: 'Climate-controlled sanctuary, plush bedding, and curated modern room conveniences.',
      imageUrl: 'https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=800&q=80',
      sectionIndex: 1,
    ),
    ExperienceCardItem(
      title: 'Gourmet Restaurant',
      tag: 'EPICUREAN',
      description: 'Artisanal dining experiences celebrating regional flavors and seasonal recipes.',
      imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=800&q=80',
      sectionIndex: 2,
    ),
    ExperienceCardItem(
      title: 'Spa & Wellness',
      tag: 'RESTORATION',
      description: 'Tranquil therapies, calming aromatics, and revitalizing wellness treatments.',
      imageUrl: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&w=800&q=80',
      sectionIndex: 3,
    ),
    ExperienceCardItem(
      title: 'Grand Banquet Hall',
      tag: 'CELEBRATIONS',
      description: 'A distinguished, versatile stage for unforgettable family and corporate gatherings.',
      imageUrl: 'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?auto=format&fit=crop&w=800&q=80',
      sectionIndex: 4,
    ),
    ExperienceCardItem(
      title: 'Atmospheric AC Bar',
      tag: 'EVENING LOUNGE',
      description: 'Intimate lighting, premier beverage selections, and sophisticated evening unwinding.',
      imageUrl: 'https://images.unsplash.com/photo-1572116469696-31de0f17cc34?auto=format&fit=crop&w=800&q=80',
      sectionIndex: 5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1100;
    final isTablet = screenWidth >= 700 && screenWidth < 1100;
    final isSmallMobile = screenWidth < 380;

    return Container(
      color: AppColors.ivoryBg,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : (isTablet ? 36 : 20),
        vertical: isDesktop ? 90 : 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SectionHeader(
                subtitle: 'DISTINCT DESTINATIONS UNDER ONE ROOF',
                title: 'Signature Experiences at Ambal Rejency',
                description:
                    'Discover an all-encompassing hospitality ecosystem thoughtfully designed to meet your every need with flair and grace.',
                scale: isSmallMobile ? 0.75 : (isDesktop ? 1.0 : 0.85),
              ),
              const SizedBox(height: 52),

              // Responsive Cards Grid / Layout
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 960) {
                    // Desktop 5-card row or 3 + 2 balanced layout
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: _buildCard(experiences[0])),
                            const SizedBox(width: 24),
                            Expanded(child: _buildCard(experiences[1])),
                            const SizedBox(width: 24),
                            Expanded(child: _buildCard(experiences[2])),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(child: _buildCard(experiences[3])),
                            const SizedBox(width: 24),
                            Expanded(child: _buildCard(experiences[4])),
                          ],
                        ),
                      ],
                    );
                  } else if (constraints.maxWidth > 600) {
                    // Tablet 2-column layout
                    return Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: experiences.map((exp) {
                        return SizedBox(
                          width: (constraints.maxWidth - 20) / 2,
                          child: _buildCard(exp),
                        );
                      }).toList(),
                    );
                  } else {
                    // Mobile stacked list
                    return Column(
                      children: experiences.map((exp) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _buildCard(exp),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(ExperienceCardItem item) {
    return _ExperienceCardWidget(
      item: item,
      onTap: () => onSelectExperience(item.sectionIndex),
    );
  }
}

class _ExperienceCardWidget extends StatefulWidget {
  final ExperienceCardItem item;
  final VoidCallback onTap;

  const _ExperienceCardWidget({required this.item, required this.onTap});

  @override
  State<_ExperienceCardWidget> createState() => _ExperienceCardWidgetState();
}

class _ExperienceCardWidgetState extends State<_ExperienceCardWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered ? AppColors.gold : AppColors.borderLight,
              width: _isHovered ? 1.5 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered ? AppColors.forestGreenDark.withOpacity(0.12) : Colors.black.withOpacity(0.04),
                blurRadius: _isHovered ? 20 : 10,
                offset: Offset(0, _isHovered ? 8 : 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image with zoom
                SizedBox(
                  height: 220,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      NetworkImageBox(
                        imageUrl: widget.item.imageUrl,
                        fit: BoxFit.cover,
                        enableZoomOnHover: true,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.4),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 14,
                        left: 14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.forestGreenDark.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: AppColors.gold.withOpacity(0.4)),
                          ),
                          child: Text(
                            widget.item.tag,
                            style: AppTypography.sans(
                              color: AppColors.goldLight,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Card Details
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.title,
                        style: AppTypography.cardTitle(
                          color: AppColors.forestGreenDark,
                          scale: 0.95,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.item.description,
                        style: AppTypography.body(fontSize: 13.5, height: 1.55),
                      ),
                      const SizedBox(height: 18),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'EXPLORE EXPERIENCE',
                              style: AppTypography.sans(
                                color: _isHovered ? AppColors.goldDark : AppColors.forestGreen,
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(width: 6),
                            AnimatedSlide(
                              offset: _isHovered ? const Offset(0.2, 0) : Offset.zero,
                              duration: const Duration(milliseconds: 200),
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                size: 15,
                                color: _isHovered ? AppColors.goldDark : AppColors.forestGreen,
                              ),
                            ),
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
      ),
    );
  }
}
