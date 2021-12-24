import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb_app/models/movie_model.dart';
import 'package:moviedb_app/repositories/search_movie_repositories.dart';

part 'searchmovie_state.dart';

class SearchmovieCubit extends Cubit<SearchmovieState> {
  SearchMoviesRepository repository = SearchMoviesRepository();
  SearchmovieCubit() : super(SearchmovieInitial());

  Future<void> getSearchMovie(String? query) async {
    try {
      emit(SearchMovieLoading());
      final result = await repository.getSearchMovies(query);
      emit(SearchMovieLoaded(searchMovie: result));
    } catch (e) {
      emit(SearchMovieFailed());
    }
  }

  void reset() => emit(SearchmovieInitial());
}
