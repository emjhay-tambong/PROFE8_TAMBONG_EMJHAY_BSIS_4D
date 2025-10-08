import 'package:flutter/material.dart';

class CleaningServiceModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final int duration; // in hours
  final IconData icon;
  final Color color;

  CleaningServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.icon,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'duration': duration,
    };
  }

  factory CleaningServiceModel.fromJson(Map<String, dynamic> json) {
    return CleaningServiceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      duration: json['duration'],
      icon: Icons.cleaning_services, // Default icon
      color: Colors.blue, // Default color
    );
  }
}
