import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mymovies_app/core/app_color.dart';
import 'package:mymovies_app/model/movel_model.dart';
import 'package:mymovies_app/mymovies_cubits/dashboard/cubit/movies_homepage_cubit.dart';
import 'package:mymovies_app/mymovies_cubits/dashboard/widgets/movie_detail_page.dart';
import 'package:mymovies_app/utils/custom_routing.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key, this.movies});
  final List<Movie>? movies;

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late Movie selectedMovie;
  TextEditingController searchController = TextEditingController();
  List<Movie> filteredMovies = [];
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    selectedMovie = widget.movies!.first;
    filteredMovies = widget.movies!;
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  void _selectMovie(Movie movie) {
    setState(() {
      selectedMovie = movie;
    });
    Navigator.push(
      context,
      CustomPageRoute(
        page: BlocProvider.value(
          value: context.read<MoviesHomepageCubit>(),
          child: MovieDetailScreen(
            movie: selectedMovie,
            releatedMovied: widget.movies ?? [],
          ),
        ),
        side: 'right',
      ),
    );
  }

  void _filterMovies(String query) {
    setState(() {
      filteredMovies = widget.movies!
          .where(
            (movie) => movie.title!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesHomepageCubit, MoviesHomepageState>(
      builder: (context, state) {
        if (state is MoviesHomepageLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              await context.read<MoviesHomepageCubit>().init();
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        AppColors.paleGreen.withOpacity(0.3),
                        AppColors.softGreen.withOpacity(0.4),
                        AppColors.lightGreen.withOpacity(0.5),
                        AppColors.mutedGreen.withOpacity(0.6),
                        AppColors.darkGreen.withOpacity(0.7),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: filteredMovies.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: TextField(
                                        controller: searchController,
                                        onChanged: _filterMovies,
                                        decoration: InputDecoration(
                                          hintText: 'Search movies...',
                                          prefixIcon: const Icon(Icons.search),
                                          suffixIcon: searchController
                                                  .text.isNotEmpty
                                              ? IconButton(
                                                  icon: const Icon(Icons.clear),
                                                  onPressed: () {
                                                    searchController.clear();
                                                    _filterMovies('');
                                                  },
                                                )
                                              : null,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: Colors.green.shade600,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              color: AppColors.darkGreen,
                                              width: 2,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                    ),
                                    const Icon(
                                      Icons.movie_filter_outlined,
                                      size: 80,
                                      color: AppColors.darkGreen,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No movies found',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.darkGreen
                                            .withOpacity(0.6),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Try searching with a different keyword',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.darkGreen
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  AnimatedOpacity(
                                    opacity: _scrollOffset > 50 ? 0 : 1,
                                    duration: const Duration(milliseconds: 300),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: TextField(
                                        controller: searchController,
                                        onChanged: _filterMovies,
                                        decoration: InputDecoration(
                                          hintText: 'Search movies...',
                                          prefixIcon: const Icon(Icons.search),
                                          suffixIcon: searchController
                                                  .text.isNotEmpty
                                              ? IconButton(
                                                  icon: const Icon(Icons.clear),
                                                  onPressed: () {
                                                    searchController.clear();
                                                    _filterMovies('');
                                                  },
                                                )
                                              : null,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: Colors.green.shade600,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              color: AppColors.darkGreen,
                                              width: 2,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Wrap(
                                      spacing: 12,
                                      runSpacing: 16,
                                      children: filteredMovies.map((movie) {
                                        return GestureDetector(
                                          onTap: () => _selectMovie(movie),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3 -
                                                20,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  spreadRadius: 2,
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius
                                                          .vertical(
                                                    top: Radius.circular(16),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        movie.posterURL ?? '',
                                                    width: double.infinity,
                                                    height: 160,
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) =>
                                                            Image.asset(
                                                      'assets/images/place_holder_150.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image.asset(
                                                      'assets/images/place_holder_150.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 8,
                                                  ),
                                                  child: Text(
                                                    movie.title ?? 'No Title',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'Rating: ${movie.imdbId ?? 'N/A'}',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
