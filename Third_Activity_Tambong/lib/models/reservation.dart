// Model class to store bike reservations
class Reservation {
  final String id;
  final String customerName;
  final String bikeType;
  final DateTime pickupDate;
  final String pickupTime;
  final int duration; // in hours
  final double totalAmount;
  final DateTime createdAt;

  Reservation({
    required this.id,
    required this.customerName,
    required this.bikeType,
    required this.pickupDate,
    required this.pickupTime,
    required this.duration,
    required this.totalAmount,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'bikeType': bikeType,
      'pickupDate': pickupDate.toIso8601String(),
      'pickupTime': pickupTime,
      'duration': duration,
      'totalAmount': totalAmount,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Reservation.fromMap(Map<String, dynamic> map) {
    return Reservation(
      id: map['id'],
      customerName: map['customerName'],
      bikeType: map['bikeType'],
      pickupDate: DateTime.parse(map['pickupDate']),
      pickupTime: map['pickupTime'],
      duration: map['duration'],
      totalAmount: map['totalAmount'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

