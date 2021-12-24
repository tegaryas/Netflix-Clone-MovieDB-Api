import 'package:dio/dio.dart';

import 'package:moviedb_app/config/config.dart';
import 'package:moviedb_app/models/movie_model.dart';

class TopRatedMovieRepository {
  Dio dio = Dio();

  Future<List<MovieModel>> getTopRatedMovies() async {
    try {
      Response response = await dio.get(Config.topRatedUrl);
      return response.data['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
