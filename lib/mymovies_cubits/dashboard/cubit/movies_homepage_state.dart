part of 'movies_homepage_cubit.dart';

class MoviesHomepageState {}

class MoviesHomepageInitial extends MoviesHomepageState {}

class MoviesHomepageLoading extends MoviesHomepageState {}

class MoviesHomepageLoaded extends MoviesHomepageState {
  MoviesHomepageLoaded({this.movies, this.favoriteMovies});
  List<Movie>? movies = [];
  List<Movie>? favoriteMovies = [];
}

class MoviesHomepageFailed extends MoviesHomepageState {}
