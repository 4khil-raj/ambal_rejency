import 'package:flutter/material.dart';
import '../../models/room_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../common/gold_button.dart';
import '../common/network_image_box.dart';

class RoomDetailsDialog extends StatefulWidget {
  final RoomModel room;
  final VoidCallback onEnquire;

  const RoomDetailsDialog({
    super.key,
    required this.room,
    required this.onEnquire,
  });

  static Future<void> show(
    BuildContext context, {
    required RoomModel room,
    required VoidCallback onEnquire,
  }) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (context) => RoomDetailsDialog(
        room: room,
        onEnquire: onEnquire,
      ),
    );
  }

  @override
  State<RoomDetailsDialog> createState() => _RoomDetailsDialogState();
}

class _RoomDetailsDialogState extends State<RoomDetailsDialog> {
  late String _activeImage;

  @override
  void initState() {
    super.initState();
    _activeImage = widget.room.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 800;
    final isSmallMobile = screenWidth < 380;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: isSmallMobile ? 12 : 24, vertical: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 880),
        decoration: BoxDecoration(
          color: AppColors.ivoryBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderGold, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with title and close button
                Container(
                  color: AppColors.forestGreenDark,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.room.title,
                          style: AppTypography.serif(
                            color: Colors.white,
                            fontSize: isSmallMobile ? 20 : 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),

                // Content
                Padding(
                  padding: EdgeInsets.all(isSmallMobile ? 16 : 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Large active photo
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                          height: isDesktop ? 360 : 220,
                          width: double.infinity,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: NetworkImageBox(
                              key: ValueKey(_activeImage),
                              imageUrl: _activeImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Image selector if additional images exist
                      if (widget.room.additionalImages.isNotEmpty) ...[
                        Row(
                          children: [
                            widget.room.imageUrl,
                            ...widget.room.additionalImages,
                          ].map((imgUrl) {
                            final isSel = _activeImage == imgUrl;
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InkWell(
                                onTap: () => setState(() => _activeImage = imgUrl),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isSel ? AppColors.gold : Colors.transparent,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: SizedBox(
                                      width: 70,
                                      height: 48,
                                      child: NetworkImageBox(imageUrl: imgUrl, fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Description
                      Text(
                        widget.room.description,
                        style: AppTypography.body(fontSize: 15, height: 1.65),
                      ),
                      const SizedBox(height: 24),

                      // Amenities List
                      Text(
                        'VERIFIED ROOM AMENITIES',
                        style: AppTypography.sans(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.forestGreenDark,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 14),

                      Wrap(
                        spacing: 12,
                        runSpacing: 10,
                        children: widget.room.amenities.map((amenity) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: AppColors.borderLight),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(amenity.icon, size: 18, color: AppColors.forestGreen),
                                const SizedBox(width: 8),
                                Text(
                                  amenity.label,
                                  style: AppTypography.sans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textCharcoal,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),

                      // Configurable details notice
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.creamBg,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: Text(
                          'Note: Exact seasonal pricing, check-in schedules, and room availability are provided upon direct reservation enquiry to guarantee personalized service.',
                          style: AppTypography.sans(fontSize: 12, color: AppColors.textMuted, height: 1.5),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Action button
                      Align(
                        alignment: Alignment.centerRight,
                        child: LuxuryButton(
                          label: 'Enquire for this Room',
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.onEnquire();
                          },
                          icon: Icons.calendar_month_outlined,
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

