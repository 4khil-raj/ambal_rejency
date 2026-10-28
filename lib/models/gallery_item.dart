enum GalleryCategory {
  all('All Perspectives'),
  rooms('Rooms & Suites'),
  dining('Restaurant & Dining'),
  wellness('Spa & Wellness'),
  banquet('Banquet Hall'),
  bar('AC Bar'),
  architecture('Architecture & Grounds');

  final String label;
  const GalleryCategory(this.label);
}

class GalleryItem {
  final String id;
  final String title;
  final String caption;
  final GalleryCategory category;
  final String imageUrl;

  const GalleryItem({
    required this.id,
    required this.title,
    required this.caption,
    required this.category,
    required this.imageUrl,
  });
}

