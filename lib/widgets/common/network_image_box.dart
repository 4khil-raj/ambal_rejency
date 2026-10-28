import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class NetworkImageBox extends StatefulWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final bool enableZoomOnHover;
  final Widget? overlay;

  const NetworkImageBox({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
    this.enableZoomOnHover = false,
    this.overlay,
  });

  @override
  State<NetworkImageBox> createState() => _NetworkImageBoxState();
}

class _NetworkImageBoxState extends State<NetworkImageBox> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = Image.network(
      widget.imageUrl,
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || frame != null) {
          return child;
        }
        return Container(
          width: widget.width,
          height: widget.height,
          color: AppColors.creamBg,
          child: const Center(
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.gold,
              ),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: AppColors.forestGreenDark,
            borderRadius: widget.borderRadius,
          ),
          padding: const EdgeInsets.all(8),
          child: const Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.hotel_rounded,
                    color: AppColors.goldLight,
                    size: 24,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Ambal Rejency',
                    style: TextStyle(
                      color: AppColors.goldLight,
                      fontSize: 10,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (widget.enableZoomOnHover) {
      imageWidget = AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        child: imageWidget,
      );
    }

    Widget content = Stack(
      fit: StackFit.passthrough,
      children: [
        imageWidget,
        if (widget.overlay != null) widget.overlay!,
      ],
    );

    if (widget.borderRadius != null) {
      content = ClipRRect(
        borderRadius: widget.borderRadius!,
        child: content,
      );
    }

    if (widget.enableZoomOnHover) {
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: content,
      );
    }

    return content;
  }
}
