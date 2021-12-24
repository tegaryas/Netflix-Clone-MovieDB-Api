import 'package:dio/dio.dart';

import 'package:moviedb_app/config/config.dart';
import 'package:moviedb_app/models/movie_model.dart';

class UpcomingMovieRepository {
  Dio dio = Dio();

  Future<List<MovieModel>> getUpcomingMovies() async {
    try {
      Response response = await dio.get(Config.upcomingMovieUrl);
      return response.data['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
