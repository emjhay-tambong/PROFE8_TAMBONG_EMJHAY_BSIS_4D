import '../models/cleaning_service_model.dart';
import '../models/booking_model.dart';

class CleaningService {
  static final CleaningService _instance = CleaningService._internal();
  factory CleaningService() => _instance;
  CleaningService._internal();

  final List<CleaningServiceModel> _services = [];
  final List<BookingModel> _bookings = [];

  List<CleaningServiceModel> get services => List.unmodifiable(_services);
  List<BookingModel> get bookings => List.unmodifiable(_bookings);

  void addService(CleaningServiceModel service) {
    _services.add(service);
  }

  void removeService(String serviceId) {
    _services.removeWhere((service) => service.id == serviceId);
  }

  CleaningServiceModel? getServiceById(String id) {
    try {
      return _services.firstWhere((service) => service.id == id);
    } catch (e) {
      return null;
    }
  }

  void addBooking(BookingModel booking) {
    _bookings.add(booking);
  }

  void updateBookingStatus(String bookingId, BookingStatus status) {
    final bookingIndex =
        _bookings.indexWhere((booking) => booking.id == bookingId);
    if (bookingIndex != -1) {
      final booking = _bookings[bookingIndex];
      final updatedBooking = BookingModel(
        id: booking.id,
        serviceName: booking.serviceName,
        date: booking.date,
        status: status,
        price: booking.price,
      );
      _bookings[bookingIndex] = updatedBooking;
    }
  }

  void cancelBooking(String bookingId) {
    updateBookingStatus(bookingId, BookingStatus.cancelled);
  }

  List<BookingModel> getBookingsByStatus(BookingStatus status) {
    return _bookings.where((booking) => booking.status == status).toList();
  }

  double getTotalRevenue() {
    return _bookings
        .where((booking) => booking.status == BookingStatus.completed)
        .fold(0.0, (sum, booking) => sum + booking.price);
  }
}
