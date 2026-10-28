import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/hotel_config.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common/brand_logo.dart';

class FooterSection extends StatelessWidget {
  final Function(int index) onNavigate;

  const FooterSection({super.key, required this.onNavigate});

  void _launchUrlHelper(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1200;
    final isTablet = screenWidth >= 640 && screenWidth < 1200;

    return Container(
      color: const Color(0xFF091611),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 60 : (isTablet ? 36 : 20),
        vertical: isDesktop ? 80 : 54,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1300),
          child: Column(
            children: [
              // Main Footer Columns
              isDesktop
                  ? _buildDesktopColumns()
                  : _buildStackedColumns(isTablet: isTablet),

              const SizedBox(height: 60),
              const Divider(color: AppColors.borderDark),
              const SizedBox(height: 30),

              // Bottom Bar: Copyright & Legal
              isDesktop
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '© 2026 ${HotelConfig.hotelName}. All Rights Reserved.',
                            style: AppTypography.sans(
                              color: AppColors.textOnDarkMuted.withValues(alpha: 0.7),
                              fontSize: 12.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Wrap(
                          spacing: 20,
                          children: [
                            _LegalLink(title: 'Privacy Policy', onTap: () {}),
                            _LegalLink(title: 'Terms of Hospitality', onTap: () {}),
                            _LegalLink(title: 'Configurable Policies', onTap: () {}),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 16,
                          runSpacing: 8,
                          children: [
                            _LegalLink(title: 'Privacy Policy', onTap: () {}),
                            _LegalLink(title: 'Terms of Hospitality', onTap: () {}),
                            _LegalLink(title: 'Configurable Policies', onTap: () {}),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '© 2026 ${HotelConfig.hotelName}. All Rights Reserved.',
                          style: AppTypography.sans(
                            color: AppColors.textOnDarkMuted.withValues(alpha: 0.7),
                            fontSize: 12.5,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopColumns() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand & Summary
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BrandLogo(isLight: true, scale: 1.1, onTap: () => onNavigate(0)),
              const SizedBox(height: 20),
              Text(
                'A distinguished address of modern luxury and warm Indian hospitality. Dedicated to providing calm accommodation, exquisite culinary journeys, and unforgettable milestone celebrations.',
                style: AppTypography.body(
                  color: AppColors.textOnDarkMuted,
                  fontSize: 14,
                  height: 1.65,
                ),
              ),
              const SizedBox(height: 24),
              // Social Links
              Row(
                children: [
                  _SocialIcon(
                    icon: Icons.camera_alt_outlined,
                    tooltip: 'Instagram',
                    onTap: () => _launchUrlHelper(HotelConfig.instagramUrl),
                  ),
                  const SizedBox(width: 12),
                  _SocialIcon(
                    icon: Icons.facebook_rounded,
                    tooltip: 'Facebook',
                    onTap: () => _launchUrlHelper(HotelConfig.facebookUrl),
                  ),
                  const SizedBox(width: 12),
                  _SocialIcon(
                    icon: Icons.business_center_outlined,
                    tooltip: 'LinkedIn',
                    onTap: () => _launchUrlHelper(HotelConfig.linkedinUrl),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 60),

        // Quick Navigation Links
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildColumnHeading('EXPLORE'),
              const SizedBox(height: 18),
              _FooterNavLink(title: 'Home', onTap: () => onNavigate(0)),
              _FooterNavLink(title: 'Rooms & Suites', onTap: () => onNavigate(1)),
              _FooterNavLink(title: 'Signature Experiences', onTap: () => onNavigate(2)),
              _FooterNavLink(title: 'Photo Gallery', onTap: () => onNavigate(6)),
              _FooterNavLink(title: 'Location & Contact', onTap: () => onNavigate(7)),
            ],
          ),
        ),

        // Offerings & Services
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildColumnHeading('HOSPITALITY SERVICES'),
              const SizedBox(height: 18),
              _FooterNavLink(title: 'AC Deluxe Rooms', onTap: () => onNavigate(1)),
              _FooterNavLink(title: 'Fine Dining Restaurant', onTap: () => onNavigate(2)),
              _FooterNavLink(title: 'Spa & Wellness Sanctuary', onTap: () => onNavigate(3)),
              _FooterNavLink(title: 'Grand Banquet Hall', onTap: () => onNavigate(4)),
              _FooterNavLink(title: 'Atmospheric AC Bar', onTap: () => onNavigate(5)),
            ],
          ),
        ),

        // Contact Directory
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildColumnHeading('CONTACT DIRECTORY'),
              const SizedBox(height: 18),
              Text(
                HotelConfig.contactAddress,
                style: AppTypography.sans(
                  color: AppColors.textOnDarkMuted,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Reservations: ${HotelConfig.contactPhoneDisplay}',
                style: AppTypography.sans(
                  color: AppColors.goldLight,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Email: ${HotelConfig.contactEmail}',
                style: AppTypography.sans(
                  color: AppColors.textOnDarkMuted,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStackedColumns({required bool isTablet}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandLogo(isLight: true, scale: 1.05, onTap: () => onNavigate(0)),
        const SizedBox(height: 16),
        Text(
          'A distinguished address of modern luxury and warm Indian hospitality.',
          style: AppTypography.body(color: AppColors.textOnDarkMuted, fontSize: 14),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 40,
          runSpacing: 30,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildColumnHeading('QUICK LINKS'),
                const SizedBox(height: 14),
                _FooterNavLink(title: 'Rooms & Suites', onTap: () => onNavigate(1)),
                _FooterNavLink(title: 'Restaurant', onTap: () => onNavigate(2)),
                _FooterNavLink(title: 'Spa & Wellness', onTap: () => onNavigate(3)),
                _FooterNavLink(title: 'Banquet Hall', onTap: () => onNavigate(4)),
                _FooterNavLink(title: 'AC Bar', onTap: () => onNavigate(5)),
                _FooterNavLink(title: 'Photo Gallery', onTap: () => onNavigate(6)),
                _FooterNavLink(title: 'Contact', onTap: () => onNavigate(7)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildColumnHeading('CONTACT DIRECTORY'),
                const SizedBox(height: 14),
                Text(
                  HotelConfig.contactAddress,
                  style: AppTypography.sans(color: AppColors.textOnDarkMuted, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Text(
                  HotelConfig.contactPhoneDisplay,
                  style: AppTypography.sans(color: AppColors.goldLight, fontSize: 13, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 6),
                Text(
                  HotelConfig.contactEmail,
                  style: AppTypography.sans(color: AppColors.textOnDarkMuted, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildColumnHeading(String text) {
    return Text(
      text,
      style: AppTypography.sans(
        color: AppColors.gold,
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 2,
      ),
    );
  }
}

class _FooterNavLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _FooterNavLink({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: AppTypography.sans(
            color: AppColors.textOnDarkMuted,
            fontSize: 13.5,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _SocialIcon({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.gold.withOpacity(0.5)),
          ),
          child: Icon(icon, color: AppColors.goldLight, size: 18),
        ),
      ),
    );
  }
}

class _LegalLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _LegalLink({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: AppTypography.sans(
          color: AppColors.textOnDarkMuted.withOpacity(0.7),
          fontSize: 12,
        ),
      ),
    );
  }
}
