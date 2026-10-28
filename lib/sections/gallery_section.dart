import 'package:flutter/material.dart';
import '../data/hotel_data.dart';
import '../models/gallery_item.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common/interactive_lightbox.dart';
import '../widgets/common/network_image_box.dart';
import '../widgets/common/section_header.dart';

class GallerySection extends StatefulWidget {
  const GallerySection({super.key});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  GalleryCategory _selectedCategory = GalleryCategory.all;

  List<GalleryItem> get _filteredItems {
    if (_selectedCategory == GalleryCategory.all) {
      return HotelData.galleryItems;
    }
    return HotelData.galleryItems.where((item) => item.category == _selectedCategory).toList();
  }

  void _openLightbox(int indexInFiltered) {
    InteractiveLightboxDialog.show(
      context,
      items: _filteredItems,
      initialIndex: indexInFiltered,
    );
  }

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SectionHeader(
                subtitle: 'VISUAL PERSPECTIVES',
                title: 'Moments Captured at Ambal Rejency',
                description:
                    'Explore our curated photo gallery showcasing our architectural spaces, elegant rooms, culinary craftsmanship, and tranquil amenities.',
                scale: isSmallMobile ? 0.75 : (isDesktop ? 1.0 : 0.85),
              ),
              const SizedBox(height: 36),

              // Filter Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: GalleryCategory.values.map((cat) {
                    final isSelected = _selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: InkWell(
                        onTap: () => setState(() => _selectedCategory = cat),
                        borderRadius: BorderRadius.circular(4),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.forestGreenDark : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: isSelected ? AppColors.forestGreenDark : AppColors.borderLight,
                            ),
                          ),
                          child: Text(
                            cat.label,
                            style: AppTypography.sans(
                              color: isSelected ? AppColors.goldLight : AppColors.textCharcoal,
                              fontSize: 12.5,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 40),

              // Responsive Image Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 3;
                  if (constraints.maxWidth < 640) {
                    crossAxisCount = 1;
                  } else if (constraints.maxWidth < 980) {
                    crossAxisCount = 2;
                  }

                  final items = _filteredItems;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: crossAxisCount == 1 ? 1.25 : 1.15,
                    ),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _GalleryCard(
                        item: item,
                        onTap: () => _openLightbox(index),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GalleryCard extends StatefulWidget {
  final GalleryItem item;
  final VoidCallback onTap;

  const _GalleryCard({required this.item, required this.onTap});

  @override
  State<_GalleryCard> createState() => _GalleryCardState();
}

class _GalleryCardState extends State<_GalleryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Main Image
              NetworkImageBox(
                imageUrl: widget.item.imageUrl,
                fit: BoxFit.cover,
                enableZoomOnHover: true,
              ),

              // Vignette & Hover Overlay
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      _isHovered ? Colors.black.withOpacity(0.85) : Colors.black.withOpacity(0.4),
                    ],
                    stops: const [0.3, 1.0],
                  ),
                ),
              ),

              // Hover Zoom Icon
              Center(
                child: AnimatedOpacity(
                  opacity: _isHovered ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.forestGreenDark.withOpacity(0.8),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.gold, width: 1.2),
                    ),
                    child: const Icon(
                      Icons.fullscreen_rounded,
                      color: AppColors.goldLight,
                      size: 26,
                    ),
                  ),
                ),
              ),

              // Title and category at bottom
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.forestGreenDark.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        widget.item.category.label.toUpperCase(),
                        style: AppTypography.sans(
                          color: AppColors.goldLight,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.item.title,
                      style: AppTypography.serif(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
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

