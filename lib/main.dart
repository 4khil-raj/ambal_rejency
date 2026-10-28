import 'dart:ui';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AmbalRejencyApp());
}

class AmbalRejencyApp extends StatelessWidget {
  const AmbalRejencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ambal Rejency | Modern Premium Hotel',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      scrollBehavior: const AppScrollBehavior(),
      home: const HomeScreen(),
    );
  }
}

/// Custom scroll behavior enabling drag scrolling on web browsers with touch, mouse and trackpad
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}
