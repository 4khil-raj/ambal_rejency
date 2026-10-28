import 'package:flutter/material.dart';
import '../data/hotel_data.dart';
import '../models/room_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common/gold_button.dart';
import '../widgets/common/network_image_box.dart';
import '../widgets/common/section_header.dart';

class RoomsSection extends StatefulWidget {
  final Function(RoomModel room) onEnquireRoom;
  final Function(RoomModel room) onViewDetails;

  const RoomsSection({
    super.key,
    required this.onEnquireRoom,
    required this.onViewDetails,
  });

  @override
  State<RoomsSection> createState() => _RoomsSectionState();
}

class _RoomsSectionState extends State<RoomsSection> {
  int _selectedRoomIndex = 0;

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Section Header
              SectionHeader(
                subtitle: 'ACCOMMODATION & SANCTUARY',
                title: 'AC Deluxe Rooms & Suites',
                description:
                    'Crafted for restorative rest with custom climate control, bespoke furnishings, and quiet elegance tailored for business and leisure travellers.',
                scale: isSmallMobile ? 0.75 : (isDesktop ? 1.0 : 0.85),
              ),
              const SizedBox(height: 48),

              // Room Tabs Switcher
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(HotelData.deluxeRooms.length, (index) {
                    final room = HotelData.deluxeRooms[index];
                    final isSelected = _selectedRoomIndex == index;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: InkWell(
                        onTap: () => setState(() => _selectedRoomIndex = index),
                        borderRadius: BorderRadius.circular(4),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.forestGreenDark : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: isSelected ? AppColors.forestGreenDark : AppColors.borderLight,
                              width: 1.2,
                            ),
                          ),
                          child: Text(
                            room.title,
                            style: AppTypography.sans(
                              color: isSelected ? AppColors.goldLight : AppColors.textCharcoal,
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 40),

              // Active Room Card Showcase
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                child: _buildRoomCard(
                  key: ValueKey(_selectedRoomIndex),
                  room: HotelData.deluxeRooms[_selectedRoomIndex],
                  isDesktop: isDesktop,
                  isTablet: isTablet,
                  isSmallMobile: isSmallMobile,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoomCard({
    required Key key,
    required RoomModel room,
    required bool isDesktop,
    required bool isTablet,
    required bool isSmallMobile,
  }) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: isDesktop
            ? IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image half
                    Expanded(
                      flex: 12,
                      child: NetworkImageBox(
                        imageUrl: room.imageUrl,
                        fit: BoxFit.cover,
                        enableZoomOnHover: true,
                      ),
                    ),

                    // Details half
                    Expanded(
                      flex: 11,
                      child: Padding(
                        padding: const EdgeInsets.all(48),
                        child: _buildRoomDetails(room),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: isSmallMobile ? 240 : 320,
                    child: NetworkImageBox(
                      imageUrl: room.imageUrl,
                      fit: BoxFit.cover,
                      enableZoomOnHover: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(isSmallMobile ? 20 : 28),
                    child: _buildRoomDetails(room),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildRoomDetails(RoomModel room) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Category Subtitle
        Text(
          room.subtitle.toUpperCase(),
          style: AppTypography.sans(
            color: AppColors.goldDark,
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
          ),
        ),
        const SizedBox(height: 8),

        // Title
        Text(
          room.title,
          style: AppTypography.cardTitle(
            color: AppColors.forestGreenDark,
            scale: 1.15,
          ),
        ),
        const SizedBox(height: 14),

        // Description
        Text(
          room.description,
          style: AppTypography.body(fontSize: 15, height: 1.65),
        ),
        const SizedBox(height: 24),

        // Amenities Grid
        Text(
          'ROOM AMENITIES & FEATURES',
          style: AppTypography.sans(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.textCharcoal,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: room.amenities.map((a) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.ivoryBg,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(a.icon, size: 16, color: AppColors.forestGreen),
                    const SizedBox(width: 8),
                    Text(
                      a.label,
                      style: AppTypography.sans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textCharcoal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 32),

        // CTAs
        Wrap(
          spacing: 14,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            LuxuryButton(
              label: 'Enquire for Room',
              onPressed: () => widget.onEnquireRoom(room),
              icon: Icons.calendar_month_outlined,
            ),
            LuxuryButton(
              label: 'View Room Details',
              type: LuxuryButtonType.goldOutline,
              onPressed: () => widget.onViewDetails(room),
            ),
          ],
        ),
      ],
    );
  }
}
