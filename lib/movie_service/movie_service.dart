import 'package:dio/dio.dart';
import 'package:mymovies_app/model/movel_model.dart';
import 'package:mymovies_app/mymovies_database/database_helper.dart';
import 'package:mymovies_app/utils/network_helper.dart';

class MovieService {
  final Dio dio = Dio();
  final String baseUrl = 'https://api.sampleapis.com/';
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<List<Movie>> fetchMovies() async {
    try {
      final connection = await NetworkHelper.isConnected();

      if (connection.name != 'none') {
        final response = await dio.get<dynamic>('${baseUrl}movies/animation');
        if (response.statusCode == 200) {
          final moviesFromAPi = (response.data as List<dynamic>)
              .map((e) => Movie.fromJson(e as Map<String, dynamic>))
              .toList();
          final dbMovies = await dbHelper.getMovies();
          if (dbMovies.isNotEmpty) {
            for (final movie in moviesFromAPi) {
              final dbMovie = dbMovies.firstWhere(
                (element) => element.id == movie.id,
                orElse: () => Movie(id: movie.id),
              );

              // database favorites updates the api res
              movie.isFavorite = dbMovie.isFavorite;
            }
          }

          await dbHelper.insertMovies(moviesFromAPi);
          return moviesFromAPi;
        } else {
          throw Exception('Failed to load data from API');
        }
      } else {
        final cachedMovies = await dbHelper.getMovies();
        if (cachedMovies.isNotEmpty) {
          return cachedMovies;
        } else {
          return [];
        }
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
