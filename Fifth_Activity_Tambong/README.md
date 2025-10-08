# 🚴 PedalPoint Bike Rental App

A comprehensive Flutter application demonstrating advanced form handling, input validation, and data management for a bike rental service.

## 📱 About The App

PedalPoint is a full-featured bike rental application that allows users to:
- Register and login with validated credentials
- Browse and select from 5 different bike types
- Make reservations with date and time selection
- View reservation history and manage bookings
- Customize app preferences and notification settings

## ✨ Features

### Authentication System
- **Login Screen** - Email and password validation
- **Registration Screen** - Complete user registration with role selection

### Bike Reservation System
- **Bike Selection** - Choose from Mountain, Road, Electric, Hybrid, or BMX bikes
- **Date & Time Picker** - Schedule your pickup time
- **Real-time Price Calculator** - See costs update as you select options
- **Reservation Confirmation** - Instant booking confirmation with details

### Data Management
- **Local Storage** - All reservations saved in memory
- **Reservation History** - View all your bookings
- **Revenue Tracking** - See total bookings and revenue
- **Delete Options** - Remove individual or all reservations

### User Preferences
- **Contact Management** - Update phone and address
- **Notifications** - Toggle Email, SMS, Push, and Newsletter preferences
- **App Settings** - Dark mode, biometrics, auto-renewal, and location services

## 🛠️ Technical Implementation

This app implements all requirements for Third Activity:
1. ✅ TextFormField with validation
2. ✅ Login form with email/password
3. ✅ Form validation (@ in email, non-empty password)
4. ✅ GlobalKey<FormState> for form management
5. ✅ Multiple input types (TextField, Checkbox, Switch)
6. ✅ Registration with name, email, password, confirm password
7. ✅ Dropdown menu for role selection
8. ✅ Date and time pickers
9. ✅ Text controller with display functionality
10. ✅ Local data storage with display

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone or download this repository

2. Navigate to the project directory:
   ```bash
   cd Third_Activity_Tambong
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## 📂 Project Structure

```
lib/
├── main.dart                           # App entry point
├── models/
│   └── reservation.dart                # Data model for reservations
├── data/
│   └── reservation_storage.dart        # Singleton storage manager
└── screens/
    ├── home_screen.dart                # Main navigation hub
    ├── login_screen.dart               # User authentication
    ├── registration_screen.dart        # New user registration
    ├── bike_reservation_screen.dart    # Bike booking interface
    ├── user_preferences_screen.dart    # Settings management
    └── reservations_list_screen.dart   # Booking history viewer
```

## 📦 Dependencies

- `flutter`: Flutter SDK
- `intl: ^0.18.0`: Internationalization and date formatting

## 🎨 UI/UX Highlights

- **Material Design 3** - Modern, clean interface
- **Gradient Backgrounds** - Visually appealing layouts
- **Responsive Forms** - Proper validation and error messages
- **Card-based Design** - Easy-to-read information display
- **Icon Integration** - Intuitive visual guidance

## 📝 Academic Information

**Course:** Mobile Development  
**Activity:** Third Activity - Forms & Input Handling  
**Student:** Tambong  
**Project:** PedalPoint Bike Rental App

For detailed requirements compliance, see [REQUIREMENTS.md](REQUIREMENTS.md)

## 🔍 Testing the App

1. **Home Screen** - Start here to navigate to different features
2. **Login** - Try logging in with any email containing "@"
3. **Register** - Create a new account and select a role
4. **Book a Bike** - Make a reservation with date/time selection
5. **My Reservations** - View all your bookings
6. **Preferences** - Customize notifications and settings

## 📄 License

This project is created for educational purposes.

## 👨‍💻 Developer

Built with ❤️ using Flutter
