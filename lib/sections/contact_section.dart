import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/hotel_config.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/common/gold_button.dart';
import '../widgets/common/section_header.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _messageController = TextEditingController();
  String _selectedService = 'AC Deluxe Room Enquiry';
  bool _isSubmitted = false;
  bool _isLoading = false;

  final List<String> _services = [
    'AC Deluxe Room Enquiry',
    'Restaurant Dining & Reservation',
    'Spa & Wellness Booking',
    'Banquet Hall & Event Hosting',
    'AC Bar Enquiries',
    'General Inquiry',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(milliseconds: 600));
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isSubmitted = true;
        });
      }
    }
  }

  void _launchUrlHelper(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
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
            children: [
              SectionHeader(
                subtitle: 'CONNECT WITH US',
                title: 'Location & Reservation Enquiries',
                description:
                    'Our dedicated hospitality associates are at your service. Reach out for room bookings, event dates, dining reservations, or custom requests.',
                scale: isSmallMobile ? 0.75 : (isDesktop ? 1.0 : 0.85),
              ),
              const SizedBox(height: 52),

              isDesktop ? _buildDesktopLayout() : _buildMobileLayout(isSmallMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Contact Cards & Map Card
        Expanded(
          flex: 11,
          child: _buildContactInfoColumn(),
        ),
        const SizedBox(width: 60),

        // Right Column: Direct Frontend Enquiry Form
        Expanded(
          flex: 12,
          child: _buildEnquiryCard(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(bool isSmallMobile) {
    return Column(
      children: [
        _buildContactInfoColumn(),
        const SizedBox(height: 40),
        _buildEnquiryCard(),
      ],
    );
  }

  Widget _buildContactInfoColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Address Card
        _buildInfoCard(
          icon: Icons.location_on_outlined,
          title: 'Hotel Address (Configurable)',
          content: HotelConfig.contactAddress,
          subtitle: 'Centrally situated with convenient access to commercial hubs and transit.',
          actionLabel: 'Get Directions',
          onAction: () => _launchUrlHelper('https://maps.google.com'),
        ),
        const SizedBox(height: 20),

        // Phone & Direct Contact
        _buildInfoCard(
          icon: Icons.phone_in_talk_outlined,
          title: 'Front Desk & Telephone',
          content: HotelConfig.contactPhoneDisplay,
          subtitle: 'Available 24/7 for guest services and immediate enquiries.',
          actionLabel: 'Call Hotel Desk',
          onAction: () => _launchUrlHelper('tel:${HotelConfig.contactPhonePlaceholder}'),
        ),
        const SizedBox(height: 20),

        // Email
        _buildInfoCard(
          icon: Icons.email_outlined,
          title: 'Official Email Enquiries',
          content: HotelConfig.contactEmail,
          subtitle: 'For corporate contracts, banquet inquiries, and stay correspondence.',
          actionLabel: 'Compose Email',
          onAction: () => _launchUrlHelper('mailto:${HotelConfig.contactEmail}'),
        ),
        const SizedBox(height: 24),

        // Styled Map Placeholder Widget
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.forestGreenDark,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.borderDark),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Subtle grid map pattern representation
              Opacity(
                opacity: 0.15,
                child: CustomPaint(painter: _MapGridPainter()),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: AppColors.gold,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.location_pin, color: AppColors.forestGreenDark, size: 28),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'AMBAL REJENCY',
                      style: AppTypography.serif(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Interactive Map Embed Slot (Configurable Coordinates)',
                      style: AppTypography.sans(
                        color: AppColors.textOnDarkMuted,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    required String subtitle,
    required String actionLabel,
    required VoidCallback onAction,
  }) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.creamBg,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Icon(icon, color: AppColors.forestGreen, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: AppTypography.sans(
                    color: AppColors.goldDark,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: AppTypography.sans(
                    color: AppColors.textCharcoal,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTypography.body(fontSize: 12.5, color: AppColors.textMuted),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: onAction,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          actionLabel,
                          style: AppTypography.sans(
                            color: AppColors.forestGreen,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward_rounded, size: 14, color: AppColors.forestGreen),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnquiryCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderGold, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 28,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: _isSubmitted ? _buildSubmissionSuccess() : _buildFormContent(),
    );
  }

  Widget _buildFormContent() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SEND AN ENQUIRY',
            style: AppTypography.sans(
              color: AppColors.goldDark,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Direct Guest Enquiry',
            style: AppTypography.cardTitle(
              color: AppColors.forestGreenDark,
              scale: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Share your intended dates and preferences. Our guest relations executive will review your enquiry promptly.',
            style: AppTypography.body(fontSize: 13.5),
          ),
          const SizedBox(height: 24),

          // Service Dropdown
          Text(
            'I AM INTERESTED IN',
            style: AppTypography.sans(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedService,
            isExpanded: true,
            decoration: _inputDecoration(hint: 'Select Interest'),
            dropdownColor: AppColors.ivoryBg,
            items: _services.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedService = val);
            },
          ),
          const SizedBox(height: 16),

          // Full Name
          Text(
            'FULL NAME',
            style: AppTypography.sans(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _nameController,
            decoration: _inputDecoration(hint: 'Your full name'),
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
          ),
          const SizedBox(height: 16),

          // Contact
          Text(
            'CONTACT NUMBER OR EMAIL',
            style: AppTypography.sans(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _contactController,
            decoration: _inputDecoration(hint: 'Phone or email address'),
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Please provide a contact method' : null,
          ),
          const SizedBox(height: 16),

          // Message
          Text(
            'MESSAGE / ENQUIRY DETAILS',
            style: AppTypography.sans(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 1),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _messageController,
            maxLines: 3,
            decoration: _inputDecoration(hint: 'Please share your preferred dates or questions...'),
          ),
          const SizedBox(height: 16),

          // Frontend Disclaimer Notice
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.creamBg,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline_rounded, color: AppColors.goldDark, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Notice: This contact form operates in frontend validation mode for demonstration. Production email dispatch will connect upon SMTP/API setup.',
                    style: AppTypography.sans(fontSize: 11.5, color: AppColors.textMuted, height: 1.45),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Submit
          SizedBox(
            width: double.infinity,
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: AppColors.gold))
                : LuxuryButton(
                    label: 'Submit Guest Enquiry',
                    isFullWidth: true,
                    onPressed: _handleSubmit,
                    icon: Icons.arrow_forward_rounded,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmissionSuccess() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.forestGreen.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_rounded, color: AppColors.forestGreen, size: 36),
        ),
        const SizedBox(height: 20),
        Text(
          'Enquiry Received',
          style: AppTypography.serif(fontSize: 26, fontWeight: FontWeight.w600, color: AppColors.forestGreenDark),
        ),
        const SizedBox(height: 10),
        Text(
          'Thank you, ${_nameController.text.trim()}. Your inquiry regarding $_selectedService has been captured on the frontend.',
          textAlign: TextAlign.center,
          style: AppTypography.body(fontSize: 14.5),
        ),
        const SizedBox(height: 24),
        LuxuryButton(
          label: 'Submit Another Enquiry',
          type: LuxuryButtonType.darkFilled,
          onPressed: () {
            setState(() {
              _isSubmitted = false;
              _nameController.clear();
              _contactController.clear();
              _messageController.clear();
            });
          },
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTypography.sans(color: AppColors.textLightMuted, fontSize: 13),
      filled: true,
      fillColor: AppColors.ivoryBg,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
