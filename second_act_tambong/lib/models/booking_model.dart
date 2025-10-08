import 'package:intl/intl.dart';

enum BookingStatus {
  pending,
  confirmed,
  completed,
  cancelled,
}

class BookingModel {
  final String id;
  final String serviceName;
  final DateTime date;
  final BookingStatus status;
  final double price;

  BookingModel({
    required this.id,
    required this.serviceName,
    required this.date,
    required this.status,
    required this.price,
  });

  String get formattedDate {
    return DateFormat('MMM dd, yyyy - HH:mm').format(date);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceName': serviceName,
      'date': date.toIso8601String(),
      'status': status.toString(),
      'price': price,
    };
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      serviceName: json['serviceName'],
      date: DateTime.parse(json['date']),
      status: BookingStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
      ),
      price: json['price'].toDouble(),
    );
  }
}
