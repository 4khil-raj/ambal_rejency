import 'package:flutter/material.dart';

class RoomAmenity {
  final IconData icon;
  final String label;

  const RoomAmenity({required this.icon, required this.label});
}

class RoomModel {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  final List<String> additionalImages;
  final List<RoomAmenity> amenities;
  final String? sizePlaceholder;
  final String? occupancyPlaceholder;

  const RoomModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
    this.additionalImages = const [],
    required this.amenities,
    this.sizePlaceholder,
    this.occupancyPlaceholder,
  });
}

