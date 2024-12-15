import 'package:mymovies_app/model/movel_model.dart';
import 'package:mymovies_app/movie_service/movie_service.dart';

class MovieController {
  final movieService = MovieService();

  Future<List<Movie>> getMovies() async {
    try {
      return await movieService.fetchMovies();
    } catch (e) {
      return [];
    }
  }
}
