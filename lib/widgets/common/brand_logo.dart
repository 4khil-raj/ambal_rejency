import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class BrandLogo extends StatelessWidget {
  final bool isLight;
  final double scale;
  final VoidCallback? onTap;

  const BrandLogo({
    super.key,
    this.isLight = true,
    this.scale = 1.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final titleColor = isLight ? AppColors.textOnDark : AppColors.forestGreenDark;
    final subtitleColor = isLight ? AppColors.goldLight : AppColors.goldDark;

    Widget logoContent = FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 7 * scale,
                height: 7 * scale,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isLight ? AppColors.goldLight : AppColors.gold,
                ),
              ),
              SizedBox(width: 8 * scale),
              Text(
                'AMBAL REJENCY',
                style: AppTypography.serif(
                  fontSize: 22 * scale,
                  fontWeight: FontWeight.w700,
                  color: titleColor,
                  letterSpacing: 2.8 * scale,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 15 * scale, top: 2 * scale),
            child: Text(
              'HOTEL & SUITES',
              style: AppTypography.sans(
                fontSize: 8.5 * scale,
                fontWeight: FontWeight.w600,
                color: subtitleColor,
                letterSpacing: 3.5 * scale,
              ),
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: logoContent,
      );
    }

    return logoContent;
  }
}
