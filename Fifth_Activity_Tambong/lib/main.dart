import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/shopping_cart_screen.dart';
import 'screens/todo_list_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/media_player_app_screen.dart';
import 'screens/user_profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/shopping_cart_provider.dart';
import 'providers/todo_provider.dart';

void main() => runApp(const PedalPointApp());

class PedalPointApp extends StatelessWidget {
  const PedalPointApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ShoppingCartProvider()),
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'PedalPoint',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            // Named routes
            initialRoute: '/login',
            routes: {
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegistrationScreen(),
              '/home': (context) => const HomeScreen(),
              '/about': (context) => const AboutScreen(),
              '/contact': (context) => const ContactScreen(),
              '/shopping-cart': (context) => const ShoppingCartScreen(),
              '/todo-list': (context) => const TodoListScreen(),
              '/gallery': (context) => const GalleryScreen(),
              '/media-player': (context) => const MediaPlayerAppScreen(),
              '/profile': (context) => const UserProfileScreen(),
            },
          );
        },
      ),
    );
  }
}
