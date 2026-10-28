import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ambal_rejency/main.dart';
import 'package:ambal_rejency/widgets/navigation/premium_nav_bar.dart';
import 'package:ambal_rejency/widgets/common/brand_logo.dart';
import 'package:ambal_rejency/sections/hero_section.dart';
import 'package:ambal_rejency/sections/intro_section.dart';
import 'package:ambal_rejency/sections/rooms_section.dart';
import 'package:ambal_rejency/sections/restaurant_section.dart';
import 'package:ambal_rejency/sections/spa_section.dart';
import 'package:ambal_rejency/sections/banquet_section.dart';
import 'package:ambal_rejency/sections/bar_section.dart';
import 'package:ambal_rejency/sections/gallery_section.dart';
import 'package:ambal_rejency/sections/contact_section.dart';
import 'package:ambal_rejency/sections/footer_section.dart';
import 'package:ambal_rejency/widgets/booking/enquiry_dialog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Ambal Rejency Hotel Website - Component & Responsiveness Tests', () {
    testWidgets('Renders all core sections on standard desktop viewport (1440x900)', (tester) async {
      tester.view.physicalSize = const Size(1440, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const AmbalRejencyApp());
      await tester.pump();

      // Brand mark exists
      expect(find.byType(BrandLogo), findsWidgets);
      expect(find.text('AMBAL REJENCY'), findsWidgets);

      // Navigation Bar exists
      expect(find.byType(PremiumNavBar), findsOneWidget);

      // Sections exist in widget hierarchy
      expect(find.byType(HeroSection), findsOneWidget);
      expect(find.byType(IntroSection), findsOneWidget);
      expect(find.byType(RoomsSection), findsOneWidget);
      expect(find.byType(RestaurantSection), findsOneWidget);
      expect(find.byType(SpaSection), findsOneWidget);
      expect(find.byType(BanquetSection), findsOneWidget);
      expect(find.byType(BarSection), findsOneWidget);
      expect(find.byType(GallerySection), findsOneWidget);
      expect(find.byType(ContactSection), findsOneWidget);
      expect(find.byType(FooterSection), findsOneWidget);

      // Verify no exceptions or overflow occurred
      expect(tester.takeException(), isNull);
    });

    final testViewports = [
      {'name': 'Small Mobile (320px)', 'size': const Size(320, 640)},
      {'name': 'Standard Mobile (375px)', 'size': const Size(375, 667)},
      {'name': 'iPhone 14/15 (390px)', 'size': const Size(390, 844)},
      {'name': 'Large Mobile (430px)', 'size': const Size(430, 932)},
      {'name': 'Tablet Portrait (768px)', 'size': const Size(768, 1024)},
      {'name': 'Tablet Landscape (820px)', 'size': const Size(820, 1180)},
      {'name': 'Small Laptop (1024px)', 'size': const Size(1024, 768)},
      {'name': 'Standard Desktop (1280px)', 'size': const Size(1280, 800)},
      {'name': 'Full HD Desktop (1920px)', 'size': const Size(1920, 1080)},
    ];

    for (final vp in testViewports) {
      testWidgets('No layout overflow on ${vp['name']}', (tester) async {
        final size = vp['size'] as Size;
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(const AmbalRejencyApp());
        await tester.pump();

        // Check for any Flutter layout overflow error
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('Enquiry modal dialog opens, validates, and simulates submission', (tester) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const AmbalRejencyApp());
      await tester.pump();

      // Tap Book a Stay in the nav bar
      final bookBtn = find.text('BOOK A STAY');
      expect(bookBtn, findsOneWidget);
      await tester.tap(bookBtn);
      await tester.pumpAndSettle();

      // EnquiryDialog is visible
      expect(find.byType(EnquiryDialog), findsOneWidget);
      expect(find.text('Reservation & Stay Enquiry'), findsOneWidget);

      // Attempt to submit without entering required name/contact
      final submitBtn = find.text('SUBMIT STAY ENQUIRY');
      expect(submitBtn, findsOneWidget);
      await tester.ensureVisible(submitBtn);
      await tester.tap(submitBtn);
      await tester.pumpAndSettle();

      // Form validation errors displayed
      expect(find.text('Please enter your name'), findsOneWidget);
      expect(find.text('Please provide a valid phone or email'), findsOneWidget);

      // Enter name and email in the dialog form fields
      final dialogFields = find.descendant(
        of: find.byType(EnquiryDialog),
        matching: find.byType(TextFormField),
      );
      await tester.enterText(dialogFields.at(0), 'Aditi Menon');
      await tester.enterText(dialogFields.at(1), 'aditi@example.com');
      await tester.pump();

      // Submit valid form
      await tester.ensureVisible(submitBtn);
      await tester.tap(submitBtn);
      await tester.pump(const Duration(milliseconds: 700));
      await tester.pumpAndSettle();

      // Verify success confirmation view
      expect(find.text('Enquiry Draft Prepared'), findsOneWidget);
      expect(find.textContaining('Aditi Menon'), findsOneWidget);

      // Close modal
      final closeBtn = find.text('CLOSE WINDOW');
      expect(closeBtn, findsOneWidget);
      await tester.tap(closeBtn);
      await tester.pumpAndSettle();

      expect(find.byType(EnquiryDialog), findsNothing);
    });

    testWidgets('Room tabs change active room card', (tester) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: RoomsSection(
              onEnquireRoom: (_) {},
              onViewDetails: (_) {},
            ),
          ),
        ),
      ));
      await tester.pump();

      // By default first room is active
      expect(find.text('AC Deluxe King Room'), findsWidgets);

      // Tap on AC Deluxe Twin Room tab
      final twinTab = find.text('AC Deluxe Twin Room');
      expect(twinTab, findsWidgets);
      await tester.tap(twinTab.first);
      await tester.pumpAndSettle();

      // Twin room description should now be visible
      expect(find.textContaining('two custom twin beds'), findsOneWidget);
    });

    testWidgets('Photo gallery category filters change visible items', (tester) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: GallerySection(),
          ),
        ),
      ));
      await tester.pump();

      // Tap Bar filter
      final barFilter = find.text('AC Bar');
      expect(barFilter, findsWidgets);
      await tester.ensureVisible(barFilter.first);
      await tester.tap(barFilter.first);
      await tester.pumpAndSettle();

      // Only bar gallery items should be present
      expect(find.text('Atmospheric AC Bar Lounge'), findsWidgets);
    });
  });
}
