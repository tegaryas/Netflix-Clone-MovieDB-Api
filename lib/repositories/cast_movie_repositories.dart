import 'package:dio/dio.dart';

import 'package:moviedb_app/config/config.dart';
import 'package:moviedb_app/models/cast_movie_model.dart';

class CastMovieRepository {
  Dio dio = Dio();

  Future<MovieCast> getCastMovie(int movieId) async {
    try {
      Response response = await dio.get(Config.movieCreditlUrl(movieId));
      return MovieCast.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
