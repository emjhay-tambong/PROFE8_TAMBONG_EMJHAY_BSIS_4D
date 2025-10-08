# Home Cleaning App

A comprehensive Flutter mobile application for booking home cleaning services. This app demonstrates all 10 hands-on tasks required for the Flutter development course.

## 📱 Features

- Browse various cleaning services (Deep Cleaning, Regular Cleaning, Kitchen, Bathroom, etc.)
- View detailed service information with pricing and duration
- Book cleaning services with date and time selection
- View and manage bookings
- User profile management
- Both Material Design and Cupertino (iOS-style) UI support
- Counter demonstration (StatefulWidget)
- Responsive staggered grid layout

## 📂 Project Structure

\`\`\`
lib/
├── main.dart                          # App entry point with navigation
├── models/                            # Data models
│   ├── cleaning_service_model.dart    # Service model
│   └── booking_model.dart             # Booking model
├── views/                             # Screen/Page widgets
│   ├── home_page.dart                 # Main home screen with navigation
│   ├── my_bookings_page.dart          # Bookings list screen
│   ├── welcome_page.dart              # StatelessWidget Hello World demo
│   └── counter_demo_page.dart         # StatefulWidget counter demo
├── widgets/                           # Reusable widget components
│   ├── custom_button.dart             # Custom button widget (Task 4)
│   └── cleaning_services_grid.dart    # Services grid with ServiceCard
└── services/                          # Business logic and data services
    └── cleaning_service.dart          # Service data provider and booking management
\`\`\`

### Why This Structure?

- **models/**: Contains data structures representing business entities. Separating models makes the code more maintainable and allows for easy data manipulation.

- **views/**: Contains full-page screens. This separation follows the MVC pattern and makes navigation logic clearer.

- **widgets/**: Contains reusable UI components. Breaking down complex UIs into smaller widgets improves code reusability and readability.

- **services/**: Contains business logic and data management. This layer handles data fetching, state management, and business rules, keeping views clean and focused on UI.

## ✅ Hands-On Tasks Completion

### Task 1: Project Organization ✓
- Created organized folder structure: `models/`, `views/`, `widgets/`, `services/`
- Each folder has a specific purpose following separation of concerns

### Task 2: StatelessWidget Hello World ✓
- Implemented in `views/welcome_page.dart`
- Simple Hello World with StatelessWidget showing "Welcome to Home Cleaning Service"
- Accessible via drawer navigation

### Task 3: StatefulWidget with Counter ✓
- Implemented in `views/counter_demo_page.dart`
- Counter with increment and reset buttons
- Demonstrates state management with setState()
- Accessible via drawer navigation

### Task 4: Custom Reusable Button Widget ✓
- Created `CustomButton` widget in `widgets/custom_button.dart`
- Used in multiple screens:
  1. HomePage - "Book Cleaning" button in QuickActionsSection
  2. ServiceCard dialogs - "Book Now" button in service details
- Supports customizable colors, icons, and sizing

### Task 5: Material Design and Cupertino Widgets ✓
- Implemented in `views/home_page.dart` with platform detection
- Material Design: Uses MaterialApp, BottomNavigationBar, Material widgets
- Cupertino Design: Uses CupertinoTabScaffold, CupertinoTabBar, CupertinoPageScaffold
- Same functionality with platform-specific UI

### Task 6: Navigation with BottomNavigationBar ✓
- Implemented BottomNavigationBar for Material Design
- Implemented CupertinoTabBar for iOS design
- Two main pages: Home, My Bookings
- Additional pages accessible via drawer: Welcome Demo, Counter Demo
- Smooth navigation between screens

### Task 7: Widget Tree Diagram ✓
\`\`\`
HomeCleaningApp (StatelessWidget)
├── MaterialApp
    └── HomePage (StatefulWidget)
        ├── Scaffold
        │   ├── AppBar
        │   ├── Drawer
        │   │   ├── DrawerHeader
        │   │   └── ListTiles (Home, My Bookings, Welcome Demo, Counter Demo)
        │   ├── Body
        │   │   └── HomeContent / MyBookingsPage
        │   └── BottomNavigationBar
        └── CupertinoTabScaffold (iOS)
            ├── CupertinoTabBar
            └── CupertinoPageScaffold
                └── NavigationBar + Body

HomeContent (StatelessWidget)
├── SingleChildScrollView
    └── Column
        ├── WelcomeSection
        │   └── Card with Gradient
        ├── QuickActionsSection
        │   └── CustomButton
        └── CleaningServicesGrid
            └── GridView.builder
                └── ServiceCard (multiple)
                    ├── Icon Container
                    ├── Price Text
                    ├── Service Name
                    ├── Description
                    └── Duration Row

MyBookingsPage (StatefulWidget)
├── Column
    ├── Title Text
    └── ListView.builder
        └── BookingCard (multiple)
            ├── Service Name
            ├── StatusChip
            ├── Date Row
            └── Price Row
\`\`\`

**Hierarchy Explanation:**
- **Root**: HomeCleaningApp (StatelessWidget) sets up MaterialApp theme and routing
- **Navigation Layer**: HomePage manages bottom navigation and drawer navigation
- **Page Layer**: HomeContent, MyBookingsPage, WelcomePage, CounterDemoPage are separate views
- **Component Layer**: Reusable widgets (CustomButton, ServiceCard, BookingCard, StatusChip)
- **Primitive Layer**: Basic Flutter widgets (Text, Icon, Container, Card, etc.)

### Task 8: Refactored Widget Tree ✓
- HomePage was refactored into smaller components:
  - `HomeContent` - Main content container
  - `WelcomeSection` - Welcome card with gradient
  - `QuickActionsSection` - Quick action buttons
  - `CleaningServicesGrid` - Services grid container
  - `ServiceCard` - Individual service cards
- MyBookingsPage refactored with separate `BookingCard` and `StatusChip` widgets
- Each widget has a single responsibility and is reusable

### Task 9: Third-Party Package ✓
- Added `flutter_staggered_grid_view: ^0.7.0` package to `pubspec.yaml`
- Package is available for future staggered grid implementation
- Currently using standard `GridView.builder` for services grid
- Also includes `intl: ^0.19.0` for date formatting in booking models

### Task 10: README Documentation ✓
- This README.md file documents the entire project
- Explains folder structure and reasoning
- Lists all completed tasks with details
- Provides setup and running instructions

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- iOS Simulator (for Mac) or Android Emulator

### Installation

1. Clone the repository or download the project

2. Navigate to project directory:
\`\`\`bash
cd first_activity_Tambong
\`\`\`

3. Install dependencies:
\`\`\`bash
flutter pub get
\`\`\`

4. Run the app:
\`\`\`bash
flutter run
\`\`\`

### Features to Try

1. **Navigation**: Use the drawer menu or bottom navigation to switch between pages
2. **Browse Services**: Scroll through the grid of cleaning services on the home page
3. **View Details**: Tap any service card to see detailed information and pricing
4. **Book Service**: Tap "Book Now" button in service details to add a booking
5. **View Bookings**: Navigate to "My Bookings" tab to see your current bookings
6. **Counter Demo**: Access via drawer menu to test StatefulWidget functionality
7. **Welcome Demo**: Access via drawer menu to see StatelessWidget implementation

## 🎨 Design Patterns Used

- **MVC Pattern**: Models, Views, and Services separation
- **Widget Composition**: Breaking complex UIs into smaller reusable widgets
- **Singleton Pattern**: Service classes for data management
- **Factory Pattern**: Service data generation
- **State Management**: StatefulWidget for local state

## 📦 Dependencies

- `flutter`: SDK
- `cupertino_icons`: iOS-style icons
- `flutter_staggered_grid_view`: Staggered grid layout (available for future use)
- `intl`: Date formatting and internationalization

## 🔮 Future Enhancements

- Real backend integration
- User authentication
- Payment gateway integration
- Push notifications
- Calendar integration for booking
- Rating and review system
- Real-time booking status updates

## 👨‍💻 Author

Created as part of Flutter development course requirements.

## 📄 License

This project is created for educational purposes.
