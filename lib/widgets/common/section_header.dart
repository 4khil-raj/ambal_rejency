import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class SectionHeader extends StatelessWidget {
  final String subtitle;
  final String title;
  final String? description;
  final bool isCenter;
  final bool isDark;
  final double scale;

  const SectionHeader({
    super.key,
    required this.subtitle,
    required this.title,
    this.description,
    this.isCenter = true,
    this.isDark = false,
    this.scale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final titleColor = isDark ? AppColors.textOnDark : AppColors.forestGreenDark;
    final descColor = isDark ? AppColors.textOnDarkMuted : AppColors.textMuted;
    final goldAccent = isDark ? AppColors.goldLight : AppColors.goldDark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Category Tag
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 18,
                height: 1.5,
                color: goldAccent,
              ),
              const SizedBox(width: 8),
              Text(
                subtitle.toUpperCase(),
                style: AppTypography.sectionSubtitle(color: goldAccent),
              ),
              const SizedBox(width: 8),
              Container(
                width: 18,
                height: 1.5,
                color: goldAccent,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Main Title
        Text(
          title,
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: AppTypography.sectionTitle(
            color: titleColor,
            scale: scale,
          ),
        ),

        // Description Paragraph
        if (description != null) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              description!,
              textAlign: isCenter ? TextAlign.center : TextAlign.start,
              style: AppTypography.body(
                color: descColor,
                fontSize: 15.5,
                height: 1.7,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
