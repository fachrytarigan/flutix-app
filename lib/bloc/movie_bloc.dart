import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix_fachry/models/models.dart';
import 'package:flutix_fachry/services/services.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is FetchMovies) {
      // Random random = Random();
      // int randomNumber = 1 + random.nextInt(10 - 1);

      List<Movie> movies = await MovieServices.getMovies(1);

      yield MovieLoaded(movies: movies);
    }
  }
}
