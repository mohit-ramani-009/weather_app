import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/theme_provider.dart';
import 'package:weather_app/screens/add_location_screen.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:weather_app/screens/theme_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'SplashScreen',

      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.getThemeMode() == ThemeMode.system
          ? ThemeMode.system
          : themeProvider.getThemeMode(),
      routes: {
        '/': (context) => HomeScreen(),
        'AddLocationScreen': (context) => AddLocationScreen(),
        'SplashScreen': (context) => SplashScreen(),
      },
    );
  }
}