part of 'genremovie_cubit.dart';

abstract class GenreMovieState extends Equatable {
  const GenreMovieState();
}

class GenreMovieInitial extends GenreMovieState {
  @override
  List<Object> get props => [];
}

class GenreMovieLoading extends GenreMovieState {
  @override
  List<Object> get props => [];
}

class GenreMovieLoaded extends GenreMovieState {
  final List<MovieModel> genreMovies;

  const GenreMovieLoaded({required this.genreMovies});

  @override
  List<Object> get props => [genreMovies];
}

class GenreMovieFailed extends GenreMovieState {
  @override
  List<Object> get props => [];
}
