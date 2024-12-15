import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymovies_app/core/app_color.dart';
import 'package:mymovies_app/mymovies_cubits/dashboard/cubit/movies_homepage_cubit.dart';
import 'package:mymovies_app/mymovies_cubits/dashboard/widgets/movie_favorites_page.dart';
import 'package:mymovies_app/mymovies_cubits/dashboard/widgets/movies_list_screen.dart';
import 'package:mymovies_app/screens/login_page.dart';

class MoviesListpages extends StatefulWidget {
  const MoviesListpages({required this.loadedstate, super.key});
  final MoviesHomepageLoaded loadedstate;
  @override
  State<MoviesListpages> createState() => _MoviesListpagesState();
}

class _MoviesListpagesState extends State<MoviesListpages> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      MovieListScreen(movies: widget.loadedstate.movies),
      MyFavoritesPage(favoriteMovies: widget.loadedstate.favoriteMovies),
    ];
  }

  void _logOut(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(builder: (context) => const LoginPage()),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesHomepageCubit, MoviesHomepageState>(
      builder: (context, state) {
        if (state is MoviesHomepageLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                _selectedIndex == 1 ? 'My Favorites' : 'Home',
                style: GoogleFonts.openSans(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: AppColors.darkGreen.withOpacity(0.7),
              actions: [
                IconButton(
                  icon: const Icon(Icons.exit_to_app, color: AppColors.white),
                  onPressed: () => _logOut(context),
                ),
              ],
            ),
            body: _screens[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 30),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border, size: 30),
                  label: 'My Favorites',
                ),
              ],
              selectedItemColor: AppColors.darkGreen,
              unselectedItemColor: AppColors.mutedGreen,
              backgroundColor: AppColors.paleGreen.withOpacity(0.8),
              type: BottomNavigationBarType.fixed,
              elevation: 8,
              showUnselectedLabels: true,
              iconSize: 30,
            ),
          );
        }
        return Container();
      },
    );
  }
}
