import 'package:flutter/material.dart';
import 'package:mymovies_app/core/app_theme.dart';
import 'package:mymovies_app/screens/login_page.dart';
import 'package:mymovies_app/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyMovies App',
      theme: MyMoviesAppTheme.myMoviesAppTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
