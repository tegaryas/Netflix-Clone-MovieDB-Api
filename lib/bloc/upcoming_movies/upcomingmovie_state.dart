part of 'upcomingmovie_cubit.dart';

abstract class UpcomingMovieState extends Equatable {
  const UpcomingMovieState();
}

class UpcomingMovieInitial extends UpcomingMovieState {
  @override
  List<Object> get props => [];
}

class UpcomingMovieLoading extends UpcomingMovieState {
  @override
  List<Object> get props => [];
}

class UpcomingMovieLoaded extends UpcomingMovieState {
  final List<MovieModel> upcomingMovies;

  const UpcomingMovieLoaded({required this.upcomingMovies});

  @override
  List<Object> get props => [upcomingMovies];
}

class UpcomingMovieFailed extends UpcomingMovieState {
  @override
  List<Object> get props => [];
}
