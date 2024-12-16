// ignore_for_file: lines_longer_than_80_chars

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymovies_app/core/app_color.dart';
import 'package:mymovies_app/model/movel_model.dart';
import 'package:mymovies_app/mymovies_cubits/dashboard/cubit/movies_homepage_cubit.dart';

class MyFavoritesPage extends StatefulWidget {
  const MyFavoritesPage({super.key, this.favoriteMovies});
  final List<Movie>? favoriteMovies;

  @override
  State<MyFavoritesPage> createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  List<Movie> updatedMovies = [];

  @override
  void initState() {
    super.initState();
    updatedMovies = widget.favoriteMovies ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesHomepageCubit, MoviesHomepageState>(
      builder: (context, state) {
        if (state is MoviesHomepageLoaded) {
          updatedMovies = state.favoriteMovies ?? [];
          return Stack(
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       colors: [
              //         Colors.transparent,
              //         AppColors.paleGreen.withOpacity(0.3),
              //         AppColors.softGreen.withOpacity(0.4),
              //         AppColors.lightGreen.withOpacity(0.5),
              //         AppColors.mutedGreen.withOpacity(0.6),
              //         AppColors.darkGreen.withOpacity(0.7),
              //       ],
              //       begin: Alignment.bottomCenter,
              //       end: Alignment.topCenter,
              //     ),
              //   ),
              // ),
              Column(
                children: [
                  if (updatedMovies.isEmpty)
                    Center(
                      child: Text(
                        'Your Favorite Movies will appear here.',
                        style: GoogleFonts.openSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.transparent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: updatedMovies.length,
                        itemBuilder: (context, index) {
                          final movie = updatedMovies[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.paleGreen.withOpacity(
                                0.3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              isThreeLine: true,
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: movie.posterURL ??
                                      'https://via.placeholder.com/150',
                                  width: 80,
                                  height: 120,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Image.network(
                                    'https://via.placeholder.com/150',
                                    fit: BoxFit.cover,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.network(
                                    'https://via.placeholder.com/150',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(
                                movie.title ?? 'Unknown',
                                style: GoogleFonts.openSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkGreen,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    'IMDb ID: ${movie.imdbId ?? 'N/A'}',
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'A gripping tale of adventure and suspense that keeps you on the edge of your seat.',
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      color: Colors.grey[800],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  context
                                      .read<MoviesHomepageCubit>()
                                      .toggleFavorite(movie);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        '${movie.title ?? 'Movie'} removed from favorites!',
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.darkGreen,
            ),
          ),
        );
      },
    );
  }
}
