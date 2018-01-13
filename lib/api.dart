import 'api_client.dart';

getPopuralMovies() {
  return agent('/3/movie/popular');
}

getMovieDetauls(int movieId) {
  return agent('/3/movie/$movieId');
}