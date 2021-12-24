import 'package:dio/dio.dart';

import 'package:moviedb_app/config/config.dart';
import 'package:moviedb_app/models/movie_detail_model.dart';

class DetailMovieRepository {
  Dio dio = Dio();

  Future<MovieDetail> getDetailMovie(int movieId) async {
    try {
      Response response = await dio.get(Config.movieDetailUrl(movieId));
      return MovieDetail.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
