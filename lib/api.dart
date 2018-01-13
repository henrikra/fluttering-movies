import 'dart:async';

import 'api_client.dart';

getPopuralMovies() => agent('/3/movie/popular');
Future getMovieDetails(int movieId) => agent('/3/movie/$movieId');
Future getMovieCredits(int movieId) => agent('/3/movie/$movieId/credits');