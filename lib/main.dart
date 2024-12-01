import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/theme_provider.dart';
import 'package:weather_app/provider/web_provider.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/search_city.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:weather_app/screens/theme_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => WebProvider()),
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
      routes: <String, WidgetBuilder>{
        '/': (context) => HomeScreen(),
        'WeatherScreen':(context)=> WeatherScreen(),
        'SplashScreen': (context) => SplashScreen(),
      },
    );
  }
}