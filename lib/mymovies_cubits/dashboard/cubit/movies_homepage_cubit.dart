import 'package:bloc/bloc.dart';
import 'package:mymovies_app/model/movel_model.dart';
import 'package:mymovies_app/movei_controller/movie_controller.dart';
import 'package:mymovies_app/mymovies_database/database_helper.dart';

part 'movies_homepage_state.dart';

class MoviesHomepageCubit extends Cubit<MoviesHomepageState> {
  MoviesHomepageCubit() : super(MoviesHomepageInitial());

  final mc = MovieController();
  final DatabaseHelper dbHelper = DatabaseHelper();
  Future<void> init() async {
    try {
      final res = await mc.getMovies();
      final favorites = await dbHelper.getFevoriteMovies();
      emit(MoviesHomepageLoaded(movies: res, favoriteMovies: favorites));
    } catch (e) {
      emit(MoviesHomepageFailed());
    }
  }

  Future<void> toggleFavorite(Movie movie) async {
    final newStatus = !(movie.isFavorite ?? false);
    try {
      await dbHelper.updateFavoriteStatus(movie.id!, isFavorite: newStatus);
      final updatedMovies = await dbHelper.getMovies();
      final favorites = await dbHelper.getFevoriteMovies();
      emit(
        MoviesHomepageLoaded(
          movies: updatedMovies,
          favoriteMovies: favorites,
        ),
      );
    } catch (e) {
      emit(MoviesHomepageFailed());
    }
  }
}
