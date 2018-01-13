import 'api_client.dart';

getPopuralMovies() => agent('/3/movie/popular');

getMovieDetails(int movieId) => agent('/3/movie/$movieId');