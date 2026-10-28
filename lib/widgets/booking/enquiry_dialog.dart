import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';
import '../common/gold_button.dart';

class EnquiryDialog extends StatefulWidget {
  final String? initialService;
  final String? roomOrEventTitle;

  const EnquiryDialog({
    super.key,
    this.initialService,
    this.roomOrEventTitle,
  });

  static Future<void> show(
    BuildContext context, {
    String? initialService,
    String? roomOrEventTitle,
  }) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.75),
      builder: (context) => EnquiryDialog(
        initialService: initialService,
        roomOrEventTitle: roomOrEventTitle,
      ),
    );
  }

  @override
  State<EnquiryDialog> createState() => _EnquiryDialogState();
}

class _EnquiryDialogState extends State<EnquiryDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _selectedService;
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitted = false;
  bool _isLoading = false;

  final List<String> _services = [
    'AC Deluxe Rooms & Suites',
    'Restaurant Dining Reservation',
    'Spa & Wellness Enquiry',
    'Banquet Hall & Event Hosting',
    'AC Bar Table Enquiry',
    'General Hospitality Enquiry',
  ];

  @override
  void initState() {
    super.initState();
    _selectedService = widget.initialService != null && _services.contains(widget.initialService)
        ? widget.initialService!
        : _services.first;

    if (widget.roomOrEventTitle != null) {
      _messageController.text = 'Enquiring regarding: ${widget.roomOrEventTitle}';
    }
  }

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
      // Simulate frontend submission feedback
      await Future.delayed(const Duration(milliseconds: 650));
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isSubmitted = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 40, vertical: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 580),
        decoration: BoxDecoration(
          color: AppColors.ivoryBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderGold, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
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
                // Dialog Header
                Container(
                  color: AppColors.forestGreenDark,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AMBAL REJENCY',
                              style: AppTypography.sans(
                                color: AppColors.gold,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Reservation & Stay Enquiry',
                              style: AppTypography.serif(
                                color: Colors.white,
                                fontSize: isMobile ? 20 : 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),

                // Dialog Body
                Padding(
                  padding: EdgeInsets.all(isMobile ? 20 : 28),
                  child: _isSubmitted ? _buildSuccessView() : _buildFormView(isMobile),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormView(bool isMobile) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Connect with our reservations desk. Please specify your requirements and our team will get back to you with confirmed availability.',
            style: AppTypography.body(fontSize: 14),
          ),
          const SizedBox(height: 20),

          // Service Dropdown
          Text(
            'SELECT EXPERIENCE / SERVICE',
            style: AppTypography.sans(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: AppColors.forestGreenDark,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedService,
            isExpanded: true,
            decoration: _inputDecoration(hint: 'Select Service'),
            dropdownColor: AppColors.ivoryBg,
            items: _services.map((s) {
              return DropdownMenuItem(
                value: s,
                child: Text(
                  s,
                  style: AppTypography.sans(fontSize: 14, color: AppColors.textCharcoal),
                ),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedService = val);
            },
          ),
          const SizedBox(height: 18),

          // Name Field
          Text(
            'YOUR FULL NAME',
            style: AppTypography.sans(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: AppColors.forestGreenDark,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _nameController,
            decoration: _inputDecoration(hint: 'e.g. Rahul Sharma'),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Please enter your name';
              return null;
            },
          ),
          const SizedBox(height: 18),

          // Contact Field (Phone or Email)
          Text(
            'PHONE NUMBER OR EMAIL',
            style: AppTypography.sans(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: AppColors.forestGreenDark,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _contactController,
            decoration: _inputDecoration(hint: 'e.g. +91 98765 43210 or yourname@email.com'),
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Please provide a valid phone or email';
              return null;
            },
          ),
          const SizedBox(height: 18),

          // Message / Dates
          Text(
            'DATES / REQUIREMENTS / NOTES',
            style: AppTypography.sans(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: AppColors.forestGreenDark,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _messageController,
            maxLines: 3,
            decoration: _inputDecoration(hint: 'Desired dates, number of guests, special requests...'),
          ),
          const SizedBox(height: 16),

          // Frontend Disclaimer Notice
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.sandBg.withOpacity(0.6),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline_rounded, color: AppColors.goldDark, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Frontend Demonstration: Live availability and booking backend will connect upon production server configuration.',
                    style: AppTypography.sans(
                      fontSize: 11.5,
                      color: AppColors.textMuted,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Submit Button
          SizedBox(
            width: double.infinity,
            child: _isLoading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(color: AppColors.gold),
                    ),
                  )
                : LuxuryButton(
                    label: 'Submit Stay Enquiry',
                    isFullWidth: true,
                    onPressed: _handleSubmit,
                    icon: Icons.arrow_forward_rounded,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.forestGreen.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(Icons.check_circle_outline_rounded, color: AppColors.forestGreen, size: 40),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Enquiry Draft Prepared',
          style: AppTypography.serif(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: AppColors.forestGreenDark,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Thank you, ${_nameController.text.trim()}. Your stay enquiry for "$_selectedService" has been processed on the frontend interface.',
          textAlign: TextAlign.center,
          style: AppTypography.body(fontSize: 14.5),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.creamBg,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Text(
            'Note: For immediate booking assistance or urgent reservations, please reach out via the contact numbers listed in the hotel directory.',
            textAlign: TextAlign.center,
            style: AppTypography.sans(fontSize: 12, color: AppColors.textMuted, height: 1.5),
          ),
        ),
        const SizedBox(height: 24),
        LuxuryButton(
          label: 'Close Window',
          type: LuxuryButtonType.darkFilled,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTypography.sans(color: AppColors.textLightMuted, fontSize: 13.5),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.borderLight, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.error, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
    );
  }
}

