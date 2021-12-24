import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb_app/models/movie_model.dart';
import 'package:moviedb_app/repositories/genre_movie_repositories.dart';

part 'genremovie_state.dart';

class GenreMovieCubit extends Cubit<GenreMovieState> {
  final GenreMovieRepository repository = GenreMovieRepository();
  GenreMovieCubit() : super(GenreMovieInitial());

  Future<void> getGenreMovies() async {
    try {
      emit(GenreMovieLoading());
      final result = await repository.getGenreMovie();
      emit(GenreMovieLoaded(genreMovies: result));
    } catch (e) {
      emit(GenreMovieFailed());
    }
  }
}
