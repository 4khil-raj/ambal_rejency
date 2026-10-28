import 'package:flutter/material.dart';
import '../models/room_model.dart';
import '../models/gallery_item.dart';

class HeroSlide {
  final String imageUrl;
  final String caption;
  final String subtitle;

  const HeroSlide({
    required this.imageUrl,
    required this.caption,
    required this.subtitle,
  });
}

class HotelData {
  // Hero Carousel Slides
  static const List<HeroSlide> heroSlides = [
    HeroSlide(
      imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1920&q=80',
      caption: 'Experience Comfort. Discover Ambal Rejency.',
      subtitle: 'Where timeless Indian warmth meets contemporary architectural elegance.',
    ),
    HeroSlide(
      imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=1920&q=80',
      caption: 'Refined Living in AC Deluxe Rooms.',
      subtitle: 'Indulge in thoughtfully crafted interiors, soothing palettes, and bespoke comfort.',
    ),
    HeroSlide(
      imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=1920&q=80',
      caption: 'A Taste Worth Remembering.',
      subtitle: 'Artisanal dining experiences celebrating delicate spices and modern culinary artistry.',
    ),
    HeroSlide(
      imageUrl: 'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?auto=format&fit=crop&w=1920&q=80',
      caption: 'Unforgettable Celebrations & Gatherings.',
      subtitle: 'Our grand Banquet Hall provides an impressive stage for cherished milestones.',
    ),
    HeroSlide(
      imageUrl: 'https://images.unsplash.com/photo-1572116469696-31de0f17cc34?auto=format&fit=crop&w=1920&q=80',
      caption: 'Evenings Reimagined at the AC Bar.',
      subtitle: 'Atmospheric ambiance, curated refreshments, and an intimate lounge retreat.',
    ),
  ];

  // AC Deluxe Rooms Showcase
  static const List<RoomModel> deluxeRooms = [
    RoomModel(
      id: 'deluxe-king',
      title: 'AC Deluxe King Room',
      subtitle: 'Bespoke Comfort & Serenity',
      description:
          'Elegantly appointed with a plush king-sized bed, individual climate control, soft ambient lighting, and rich timber accents tailored for a deeply restorative stay.',
      imageUrl: 'https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=1200&q=80',
      additionalImages: [
        'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=1000&q=80',
        'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=1000&q=80',
      ],
      amenities: [
        RoomAmenity(icon: Icons.ac_unit_rounded, label: 'Climate AC'),
        RoomAmenity(icon: Icons.king_bed_outlined, label: 'King Bed'),
        RoomAmenity(icon: Icons.wifi_rounded, label: 'High-Speed Wi-Fi'),
        RoomAmenity(icon: Icons.tv_rounded, label: 'Smart HD TV'),
        RoomAmenity(icon: Icons.shower_outlined, label: 'Ensuite Bath'),
        RoomAmenity(icon: Icons.coffee_maker_outlined, label: 'Tea & Coffee'),
      ],
      sizePlaceholder: 'Spacious layout',
      occupancyPlaceholder: 'Double Occupancy',
    ),
    RoomModel(
      id: 'deluxe-twin',
      title: 'AC Deluxe Twin Room',
      subtitle: 'Flexible & Elegant Hospitality',
      description:
          'Featuring two custom twin beds with ultra-comfortable mattresses, an executive workspace, and generous dressing space suitable for business partners or companions.',
      imageUrl: 'https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?auto=format&fit=crop&w=1200&q=80',
      additionalImages: [
        'https://images.unsplash.com/photo-1591088398332-8a7791972843?auto=format&fit=crop&w=1000&q=80',
      ],
      amenities: [
        RoomAmenity(icon: Icons.ac_unit_rounded, label: 'Climate AC'),
        RoomAmenity(icon: Icons.bed_outlined, label: 'Twin Beds'),
        RoomAmenity(icon: Icons.wifi_rounded, label: 'High-Speed Wi-Fi'),
        RoomAmenity(icon: Icons.desk_rounded, label: 'Work Desk'),
        RoomAmenity(icon: Icons.shower_outlined, label: 'Rain Shower'),
        RoomAmenity(icon: Icons.room_service_outlined, label: 'Room Service'),
      ],
      sizePlaceholder: 'Generous layout',
      occupancyPlaceholder: '2 Guests',
    ),
    RoomModel(
      id: 'executive-suite',
      title: 'AC Executive Deluxe Suite',
      subtitle: 'Panoramic Luxury & Expanded Living',
      description:
          'A distinguished corner suite designed with a separate living lounge, deep emerald design touches, floor-to-ceiling drapery, and enhanced personal amenities.',
      imageUrl: 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&w=1200&q=80',
      additionalImages: [
        'https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=1000&q=80',
      ],
      amenities: [
        RoomAmenity(icon: Icons.ac_unit_rounded, label: 'Individual Climate AC'),
        RoomAmenity(icon: Icons.weekend_outlined, label: 'Lounge Area'),
        RoomAmenity(icon: Icons.king_bed_outlined, label: 'Master King Bed'),
        RoomAmenity(icon: Icons.wifi_rounded, label: 'Ultra Wi-Fi'),
        RoomAmenity(icon: Icons.bathtub_outlined, label: 'Luxury Bath'),
        RoomAmenity(icon: Icons.star_outline_rounded, label: 'Priority Service'),
      ],
      sizePlaceholder: 'Expanded suite layout',
      occupancyPlaceholder: '2-3 Guests',
    ),
  ];

  // Gallery Photos
  static const List<GalleryItem> galleryItems = [
    GalleryItem(
      id: 'gal-1',
      title: 'Grand Facade & Grounds',
      caption: 'The welcoming entrance architecture of Ambal Rejency illuminated at dusk.',
      category: GalleryCategory.architecture,
      imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1200&q=80',
    ),
    GalleryItem(
      id: 'gal-2',
      title: 'AC Deluxe Master Room',
      caption: 'Restful bedroom styling highlighting refined wood textures and calm palettes.',
      category: GalleryCategory.rooms,
      imageUrl: 'https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=1200&q=80',
    ),
    GalleryItem(
      id: 'gal-3',
      title: 'Restaurant Dining Hall',
      caption: 'Sophisticated dining ambiance bathed in warm chandeliers and attentive service.',
      category: GalleryCategory.dining,
      imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=1200&q=80',
    ),
    GalleryItem(
      id: 'gal-4',
      title: 'Spa & Rejuvenation Pavilion',
      caption: 'Serene spaces calibrated to restore harmony for body, mind, and spirit.',
      category: GalleryCategory.wellness,
      imageUrl: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&w=1200&q=80',
    ),
    GalleryItem(
      id: 'gal-5',
      title: 'Grand Banquet Celebration Hall',
      caption: 'Majestic banquet settings tailored for memorable receptions and corporate banquets.',
      category: GalleryCategory.banquet,
      imageUrl: 'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?auto=format&fit=crop&w=1200&q=80',
    ),
    GalleryItem(
      id: 'gal-6',
      title: 'Atmospheric AC Bar Lounge',
      caption: 'Rich textures, muted illumination, and sophisticated evening relaxation.',
      category: GalleryCategory.bar,
      imageUrl: 'https://images.unsplash.com/photo-1572116469696-31de0f17cc34?auto=format&fit=crop&w=1200&q=80',
    ),
    GalleryItem(
      id: 'gal-7',
      title: 'Executive Deluxe Suite Interior',
      caption: 'Contemporary furnishings with subtle luxury details and serene privacy.',
      category: GalleryCategory.rooms,
      imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=1200&q=80',
    ),
    GalleryItem(
      id: 'gal-8',
      title: 'Artisanal Culinary Plating',
      caption: 'Fresh regional ingredients elevated into sensory gastronomic delights.',
      category: GalleryCategory.dining,
      imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=1200&q=80',
    ),
    GalleryItem(
      id: 'gal-9',
      title: 'Wellness Stone & Flora Details',
      caption: 'Natural wellness aromas and gentle therapy rooms.',
      category: GalleryCategory.wellness,
      imageUrl: 'https://images.unsplash.com/photo-1600334129128-685c5582fd35?auto=format&fit=crop&w=1200&q=80',
    ),
    GalleryItem(
      id: 'gal-10',
      title: 'Evening Gathering Table Decor',
      caption: 'Bespoke banquet setups with elegant crystal and golden accents.',
      category: GalleryCategory.banquet,
      imageUrl: 'https://images.unsplash.com/photo-1464366400600-7168b8af9bc3?auto=format&fit=crop&w=1200&q=80',
    ),
    GalleryItem(
      id: 'gal-11',
      title: 'Bar Counter & Spirits Selection',
      caption: 'Expertly curated beverages served in an exclusive, air-conditioned lounge setting.',
      category: GalleryCategory.bar,
      imageUrl: 'https://images.unsplash.com/photo-1514933651103-005eec06c04b?auto=format&fit=crop&w=1200&q=80',
    ),
    GalleryItem(
      id: 'gal-12',
      title: 'Architectural Courtyard & Pool',
      caption: 'Reflecting waters and landscaped courtyards framing the hotel exterior.',
      category: GalleryCategory.architecture,
      imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1200&q=80',
    ),
  ];
}
