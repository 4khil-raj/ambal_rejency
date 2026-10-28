import 'package:flutter/material.dart';
import '../models/room_model.dart';
import '../sections/banquet_section.dart';
import '../sections/bar_section.dart';
import '../sections/contact_section.dart';
import '../sections/experiences_section.dart';
import '../sections/footer_section.dart';
import '../sections/gallery_section.dart';
import '../sections/hero_section.dart';
import '../sections/intro_section.dart';
import '../sections/restaurant_section.dart';
import '../sections/reviews_placeholder_section.dart';
import '../sections/rooms_section.dart';
import '../sections/spa_section.dart';
import '../theme/app_colors.dart';
import '../widgets/booking/enquiry_dialog.dart';
import '../widgets/booking/room_details_dialog.dart';
import '../widgets/navigation/mobile_nav_drawer.dart';
import '../widgets/navigation/premium_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isScrolled = false;
  int _activeNavIndex = 0;

  // Section Keys for smooth scrolling
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _introKey = GlobalKey();
  final GlobalKey _roomsKey = GlobalKey();
  final GlobalKey _experiencesKey = GlobalKey();
  final GlobalKey _restaurantKey = GlobalKey();
  final GlobalKey _spaKey = GlobalKey();
  final GlobalKey _banquetKey = GlobalKey();
  final GlobalKey _barKey = GlobalKey();
  final GlobalKey _galleryKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final offset = _scrollController.offset;
    if (offset > 60 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (offset <= 60 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  void _scrollToKey(GlobalKey key, {int? navIndex}) {
    if (navIndex != null) {
      setState(() => _activeNavIndex = navIndex);
    }
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOutCubic,
        alignment: 0.05,
      );
    }
  }

  void _handleNavSelect(int index) {
    setState(() => _activeNavIndex = index);
    switch (index) {
      case 0:
        _scrollToKey(_heroKey, navIndex: 0);
        break;
      case 1:
        _scrollToKey(_roomsKey, navIndex: 1);
        break;
      case 2:
        _scrollToKey(_restaurantKey, navIndex: 2);
        break;
      case 3:
        _scrollToKey(_spaKey, navIndex: 3);
        break;
      case 4:
        _scrollToKey(_banquetKey, navIndex: 4);
        break;
      case 5:
        _scrollToKey(_barKey, navIndex: 5);
        break;
      case 6:
        _scrollToKey(_galleryKey, navIndex: 6);
        break;
      case 7:
        _scrollToKey(_contactKey, navIndex: 7);
        break;
    }
  }

  void _openEnquiryModal({String? initialService, String? roomOrEventTitle}) {
    EnquiryDialog.show(
      context,
      initialService: initialService,
      roomOrEventTitle: roomOrEventTitle,
    );
  }

  void _openRoomDetails(RoomModel room) {
    RoomDetailsDialog.show(
      context,
      room: room,
      onEnquire: () => _openEnquiryModal(
        initialService: 'AC Deluxe Rooms & Suites',
        roomOrEventTitle: room.title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.ivoryBg,
      endDrawer: MobileNavDrawer(
        activeIndex: _activeNavIndex,
        onNavItemSelected: _handleNavSelect,
        onBookStayPressed: () => _openEnquiryModal(initialService: 'AC Deluxe Rooms & Suites'),
      ),
      body: Stack(
        children: [
          // Main Scrollable Content
          SelectionArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Hero Section
                  Container(
                    key: _heroKey,
                    child: HeroSection(
                      onExploreRooms: () => _scrollToKey(_roomsKey, navIndex: 1),
                      onDiscoverExperiences: () => _scrollToKey(_experiencesKey),
                      onScrollDown: () => _scrollToKey(_introKey),
                    ),
                  ),

                  // Introduction Section
                  Container(
                    key: _introKey,
                    child: IntroSection(
                      onDiscoverStory: () => _scrollToKey(_roomsKey, navIndex: 1),
                    ),
                  ),

                  // AC Deluxe Rooms Showcase
                  Container(
                    key: _roomsKey,
                    child: RoomsSection(
                      onEnquireRoom: (room) => _openEnquiryModal(
                        initialService: 'AC Deluxe Rooms & Suites',
                        roomOrEventTitle: room.title,
                      ),
                      onViewDetails: _openRoomDetails,
                    ),
                  ),

                  // Signature Experiences Overview
                  Container(
                    key: _experiencesKey,
                    child: ExperiencesSection(
                      onSelectExperience: (index) {
                        switch (index) {
                          case 1:
                            _scrollToKey(_roomsKey, navIndex: 1);
                            break;
                          case 2:
                            _scrollToKey(_restaurantKey, navIndex: 2);
                            break;
                          case 3:
                            _scrollToKey(_spaKey, navIndex: 3);
                            break;
                          case 4:
                            _scrollToKey(_banquetKey, navIndex: 4);
                            break;
                          case 5:
                            _scrollToKey(_barKey, navIndex: 5);
                            break;
                        }
                      },
                    ),
                  ),

                  // Restaurant Experience Section
                  Container(
                    key: _restaurantKey,
                    child: RestaurantSection(
                      onReserveTable: () => _openEnquiryModal(initialService: 'Restaurant Dining Reservation'),
                      onExploreMenu: () => _openEnquiryModal(
                        initialService: 'Restaurant Dining Reservation',
                        roomOrEventTitle: 'Menu & Chef Special Inquiries',
                      ),
                    ),
                  ),

                  // Spa & Wellness Section
                  Container(
                    key: _spaKey,
                    child: SpaSection(
                      onEnquireSpa: () => _openEnquiryModal(initialService: 'Spa & Wellness Enquiry'),
                    ),
                  ),

                  // Banquet Hall Section
                  Container(
                    key: _banquetKey,
                    child: BanquetSection(
                      onEnquireEvents: () => _openEnquiryModal(initialService: 'Banquet Hall & Event Hosting'),
                    ),
                  ),

                  // Atmospheric AC Bar Section
                  Container(
                    key: _barKey,
                    child: BarSection(
                      onExploreBar: () => _openEnquiryModal(initialService: 'AC Bar Table Enquiry'),
                      onContactHotel: () => _scrollToKey(_contactKey, navIndex: 7),
                    ),
                  ),

                  // Interactive Photo Gallery
                  Container(
                    key: _galleryKey,
                    child: const GallerySection(),
                  ),

                  // Authentic Reviews Placeholder
                  const ReviewsPlaceholderSection(),

                  // Location and Reservation Enquiries
                  Container(
                    key: _contactKey,
                    child: const ContactSection(),
                  ),

                  // Footer
                  FooterSection(
                    onNavigate: _handleNavSelect,
                  ),
                ],
              ),
            ),
          ),

          // Floating Navigation Bar at Top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PremiumNavBar(
              isScrolled: _isScrolled,
              activeIndex: _activeNavIndex,
              onNavItemSelected: _handleNavSelect,
              onBookStayPressed: () => _openEnquiryModal(initialService: 'AC Deluxe Rooms & Suites'),
              onOpenMobileMenu: () => _scaffoldKey.currentState?.openEndDrawer(),
            ),
          ),

          // Floating Back-to-Top Button
          if (_isScrolled)
            Positioned(
              bottom: 28,
              right: 28,
              child: FloatingActionButton.small(
                backgroundColor: AppColors.forestGreenDark,
                foregroundColor: AppColors.goldLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: AppColors.gold, width: 1.2),
                ),
                tooltip: 'Back to Top',
                onPressed: () => _scrollToKey(_heroKey, navIndex: 0),
                child: const Icon(Icons.arrow_upward_rounded, size: 20),
              ),
            ),
        ],
      ),
    );
  }
}

