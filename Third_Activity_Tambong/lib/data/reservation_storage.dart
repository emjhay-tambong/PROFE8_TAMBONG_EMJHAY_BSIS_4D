import '../models/reservation.dart';

// Requirement 10: Local list to store submitted data
class ReservationStorage {
  static final ReservationStorage _instance = ReservationStorage._internal();
  factory ReservationStorage() => _instance;
  ReservationStorage._internal();

  final List<Reservation> _reservations = [];

  List<Reservation> get reservations => List.unmodifiable(_reservations);

  void addReservation(Reservation reservation) {
    _reservations.add(reservation);
  }

  void removeReservation(String id) {
    _reservations.removeWhere((reservation) => reservation.id == id);
  }

  void clearAll() {
    _reservations.clear();
  }

  int get count => _reservations.length;

  double get totalRevenue {
    return _reservations.fold(0.0, (sum, item) => sum + item.totalAmount);
  }
}

