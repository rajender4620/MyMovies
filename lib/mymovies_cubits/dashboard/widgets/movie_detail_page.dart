// ignore_for_file: lines_longer_than_80_chars

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymovies_app/core/app_color.dart';
import 'package:mymovies_app/model/movel_model.dart';
import 'package:mymovies_app/mymovies_cubits/dashboard/cubit/movies_homepage_cubit.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({
    required this.movie,
    required this.releatedMovied,
    super.key,
  });

  final Movie movie;
  final List<Movie> releatedMovied;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  Movie updatedmovie = Movie();
  @override
  void initState() {
    super.initState();
    updatedmovie = updatedmovie;
  }

  @override
  Widget build(BuildContext context) {
    updatedmovie = widget.movie;
    const imdbId = 'tt0468569';
    const description =
        'When the menace known as The Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham. The Dark Knight must accept one of the greatest psychological and physical tests of his ability to fight injustice.';
    final genres = <String>['Action', 'Crime', 'Drama'];
    final cast = <String>[
      'Christian Bale',
      'Heath Ledger',
      'Aaron Eckhart',
      'Michael Caine',
      'Maggie Gyllenhaal',
    ];
    const imdbRating = 9;
    return BlocBuilder<MoviesHomepageCubit, MoviesHomepageState>(
      builder: (context, state) {
        if (state is MoviesHomepageLoaded) {
          updatedmovie = state.movies!
              .where((element) => element.id == updatedmovie.id)
              .toList()
              .first;
          return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              backgroundColor: AppColors.darkGreen,
              title: Text(
                updatedmovie.title ?? 'Movie Name',
                style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    updatedmovie.isFavorite!
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: updatedmovie.isFavorite! ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    context
                        .read<MoviesHomepageCubit>()
                        .toggleFavorite(updatedmovie);
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: updatedmovie.posterURL ?? '',
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image.asset(
                        'assets/images/place_holder_150.png',
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/place_holder_150.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          updatedmovie.title ?? 'Movie Name',
                          style: GoogleFonts.openSans(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGreen,
                            letterSpacing: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),

                        Text(
                          'IMDb ID: $imdbId',
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.mutedGreen,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        // IMDb Rating
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.yellow.shade700),
                            Text(
                              imdbRating.toString(),
                              style: GoogleFonts.openSans(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkGreen,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Movie Description
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            description,
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              color: AppColors.mutedGreen,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Genres Section
                        Text(
                          'Genres',
                          style: GoogleFonts.openSans(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGreen,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: genres.map((genre) {
                            return Chip(
                              label: Text(genre),
                              backgroundColor:
                                  AppColors.darkGreen.withOpacity(0.1),
                              labelStyle: GoogleFonts.openSans(
                                color: AppColors.darkGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),

                        // Cast Section
                        Text(
                          'Cast',
                          style: GoogleFonts.openSans(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGreen,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: cast.map((actor) {
                            return Chip(
                              label: Text(actor),
                              backgroundColor:
                                  AppColors.darkGreen.withOpacity(0.1),
                              labelStyle: GoogleFonts.openSans(
                                color: AppColors.darkGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),

                        Text(
                          'Related Movies',
                          style: GoogleFonts.openSans(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkGreen,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 160,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.releatedMovied.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: widget
                                            .releatedMovied[index].posterURL ??
                                        'https://via.placeholder.com/150',
                                    width: 120,
                                    height: 160,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Image.network(
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
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 30),

                        ElevatedButton.icon(
                          onPressed: () {
                            context
                                .read<MoviesHomepageCubit>()
                                .toggleFavorite(updatedmovie);
                          },
                          icon: Icon(
                            updatedmovie.isFavorite!
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: updatedmovie.isFavorite!
                                ? Colors.red
                                : Colors.grey,
                          ),
                          label: Text(
                            updatedmovie.isFavorite!
                                ? 'Added to Favourites'
                                : 'Add to Favourites',
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkGreen,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
