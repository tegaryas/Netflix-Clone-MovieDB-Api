import 'package:dio/dio.dart';

import 'package:moviedb_app/config/config.dart';
import 'package:moviedb_app/models/movie_model.dart';

class SearchMoviesRepository {
  Dio dio = Dio();

  Future<List<MovieModel>> getSearchMovies(String? query) async {
    try {
      Response response =
          await dio.get('${Config.searchMovieUrl}&query=$query');
      return response.data['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
