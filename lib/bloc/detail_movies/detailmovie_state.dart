part of 'detailmovie_cubit.dart';

abstract class DetailMovieState extends Equatable {
  const DetailMovieState();
}

class DetailMovieInitial extends DetailMovieState {
  @override
  List<Object> get props => [];
}

class DetailMovieLoading extends DetailMovieState {
  @override
  List<Object> get props => [];
}

class DetailMovieLoaded extends DetailMovieState {
  final MovieDetail detailMovies;

  const DetailMovieLoaded({required this.detailMovies});

  @override
  List<Object> get props => [detailMovies];
}

class DetailMovieFailed extends DetailMovieState {
  @override
  List<Object> get props => [];
}
