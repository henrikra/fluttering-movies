import 'api_client.dart';

getPopuralMovies() {
  return agent('/3/movie/popular');
}

getMovieDetails(int movieId) {
  return agent('/3/movie/$movieId');
}