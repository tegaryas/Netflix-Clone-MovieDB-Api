import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb_app/models/movie_model.dart';
import 'package:moviedb_app/repositories/upcoming_movie_repositories.dart';

part 'upcomingmovie_state.dart';

class UpcomingMovieCubit extends Cubit<UpcomingMovieState> {
  final UpcomingMovieRepository repository = UpcomingMovieRepository();
  UpcomingMovieCubit() : super(UpcomingMovieInitial());

  Future<void> getUpcomingMovies() async {
    try {
      emit(UpcomingMovieLoading());
      final result = await repository.getUpcomingMovies();
      emit(UpcomingMovieLoaded(upcomingMovies: result));
    } catch (e) {
      emit(UpcomingMovieFailed());
    }
  }
}
