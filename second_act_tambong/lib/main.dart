import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'views/home_page.dart';

void main() {
  // Ensure CanvasKit renderer is used for web to avoid HTML renderer deprecation
  if (kIsWeb) {
    // CanvasKit renderer is now configured in web/index.html
    // This provides better performance and avoids text rendering issues
  }
  runApp(const HomeCleaningApp());
}

class HomeCleaningApp extends StatelessWidget {
  const HomeCleaningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Cleaning Service',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
