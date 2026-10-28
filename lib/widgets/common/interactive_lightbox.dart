import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/gallery_item.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import 'network_image_box.dart';

class InteractiveLightboxDialog extends StatefulWidget {
  final List<GalleryItem> items;
  final int initialIndex;

  const InteractiveLightboxDialog({
    super.key,
    required this.items,
    required this.initialIndex,
  });

  static Future<void> show(
    BuildContext context, {
    required List<GalleryItem> items,
    required int initialIndex,
  }) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.92),
      builder: (context) => InteractiveLightboxDialog(
        items: items,
        initialIndex: initialIndex,
      ),
    );
  }

  @override
  State<InteractiveLightboxDialog> createState() => _InteractiveLightboxDialogState();
}

class _InteractiveLightboxDialogState extends State<InteractiveLightboxDialog> {
  late int _currentIndex;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentIndex < widget.items.length - 1) {
      setState(() => _currentIndex++);
    } else {
      setState(() => _currentIndex = 0);
    }
  }

  void _prev() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    } else {
      setState(() => _currentIndex = widget.items.length - 1);
    }
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        _next();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        _prev();
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = widget.items[_currentIndex];
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Backdrop dismiss area
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
              ),
            ),

            // Content Area
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 64,
                vertical: isMobile ? 24 : 40,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header Bar (Counter + Close)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.gold.withOpacity(0.3)),
                        ),
                        child: Text(
                          '${_currentIndex + 1} / ${widget.items.length}  •  ${currentItem.category.label}',
                          style: AppTypography.sans(
                            color: AppColors.goldLight,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Close (Esc)',
                        icon: const Icon(Icons.close_rounded, color: Colors.white, size: 28),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Image Viewer with Left/Right Controls
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (!isMobile)
                          _LightboxNavButton(
                            icon: Icons.chevron_left_rounded,
                            onTap: _prev,
                            tooltip: 'Previous',
                          ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Center(
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 350),
                              transitionBuilder: (child, animation) => FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(
                                  scale: Tween<double>(begin: 0.98, end: 1.0).animate(animation),
                                  child: child,
                                ),
                              ),
                              child: ClipRRect(
                                key: ValueKey(currentItem.id),
                                borderRadius: BorderRadius.circular(6),
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: MediaQuery.of(context).size.height * 0.68,
                                    maxWidth: 960,
                                  ),
                                  child: NetworkImageBox(
                                    imageUrl: currentItem.imageUrl,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        if (!isMobile)
                          _LightboxNavButton(
                            icon: Icons.chevron_right_rounded,
                            onTap: _next,
                            tooltip: 'Next',
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Mobile Controls Row
                  if (isMobile)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _LightboxNavButton(
                            icon: Icons.chevron_left_rounded,
                            onTap: _prev,
                            tooltip: 'Previous',
                          ),
                          const SizedBox(width: 24),
                          _LightboxNavButton(
                            icon: Icons.chevron_right_rounded,
                            onTap: _next,
                            tooltip: 'Next',
                          ),
                        ],
                      ),
                    ),

                  // Caption & Title
                  Container(
                    constraints: const BoxConstraints(maxWidth: 720),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currentItem.title,
                          textAlign: TextAlign.center,
                          style: AppTypography.serif(
                            color: Colors.white,
                            fontSize: isMobile ? 20 : 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          currentItem.caption,
                          textAlign: TextAlign.center,
                          style: AppTypography.body(
                            color: AppColors.textOnDarkMuted,
                            fontSize: 13.5,
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
    );
  }
}

class _LightboxNavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

  const _LightboxNavButton({
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.white.withOpacity(0.09),
        shape: const CircleBorder(
          side: BorderSide(color: AppColors.gold, width: 1),
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }
}

