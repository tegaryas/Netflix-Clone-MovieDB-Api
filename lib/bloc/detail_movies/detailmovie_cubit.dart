import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb_app/models/movie_detail_model.dart';
import 'package:moviedb_app/repositories/detail_movie_repositories.dart';

part 'detailmovie_state.dart';

class DetailMovieCubit extends Cubit<DetailMovieState> {
  final DetailMovieRepository repository = DetailMovieRepository();
  DetailMovieCubit() : super(DetailMovieInitial());

  Future<void> getDetailMovies(int movieId) async {
    try {
      emit(DetailMovieLoading());
      final result = await repository.getDetailMovie(movieId);
      emit(DetailMovieLoaded(detailMovies: result));
    } catch (e) {
      emit(DetailMovieFailed());
    }
  }
}
