import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

enum LuxuryButtonType {
  goldFilled,
  goldOutline,
  darkFilled,
  textOnly,
}

class LuxuryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final LuxuryButtonType type;
  final IconData? icon;
  final bool isFullWidth;
  final double? customPaddingH;
  final double? customPaddingV;
  final double fontSize;

  const LuxuryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = LuxuryButtonType.goldFilled,
    this.icon,
    this.isFullWidth = false,
    this.customPaddingH,
    this.customPaddingV,
    this.fontSize = 13.0,
  });

  @override
  State<LuxuryButton> createState() => _LuxuryButtonState();
}

class _LuxuryButtonState extends State<LuxuryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    Border? border;

    switch (widget.type) {
      case LuxuryButtonType.goldFilled:
        bg = _isHovered ? AppColors.goldLight : AppColors.gold;
        fg = AppColors.forestGreenDark;
        border = Border.all(color: _isHovered ? AppColors.goldLight : AppColors.gold);
        break;

      case LuxuryButtonType.goldOutline:
        bg = _isHovered ? AppColors.gold.withValues(alpha: 0.12) : Colors.transparent;
        fg = _isHovered ? AppColors.goldLight : AppColors.gold;
        border = Border.all(color: _isHovered ? AppColors.goldLight : AppColors.gold, width: 1.2);
        break;

      case LuxuryButtonType.darkFilled:
        bg = _isHovered ? AppColors.forestGreenLight : AppColors.forestGreen;
        fg = _isHovered ? AppColors.pureWhite : AppColors.textOnDark;
        border = Border.all(color: AppColors.gold.withValues(alpha: 0.4), width: 1);
        break;

      case LuxuryButtonType.textOnly:
        bg = Colors.transparent;
        fg = _isHovered ? AppColors.goldDark : AppColors.forestGreen;
        border = null;
        break;
    }

    Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      padding: EdgeInsets.symmetric(
        horizontal: widget.customPaddingH ?? 20,
        vertical: widget.customPaddingV ?? 13,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
        border: border,
        boxShadow: (widget.type == LuxuryButtonType.goldFilled && _isHovered)
            ? [
                BoxShadow(
                  color: AppColors.gold.withValues(alpha: 0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: widget.isFullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.label.toUpperCase(),
              style: AppTypography.button(
                color: fg,
                fontSize: widget.fontSize,
              ),
            ),
            if (widget.icon != null) ...[
              const SizedBox(width: 8),
              AnimatedSlide(
                offset: _isHovered ? const Offset(0.2, 0) : Offset.zero,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  widget.icon,
                  color: fg,
                  size: widget.fontSize + 4,
                ),
              ),
            ],
          ],
        ),
      ),
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: content,
      ),
    );
  }
}
