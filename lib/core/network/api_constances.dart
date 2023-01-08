class ApiConstance {
  //"https://api.themoviedb.org/3/movie/now_playing?api_key=6a0f93ed67b891b10e7c02cffda82c07"

  static const basUrl = "https://api.themoviedb.org/3";
  static const apiKey = "6a0f93ed67b891b10e7c02cffda82c07";
  static const nowPlayingMoviesPath =
      "$basUrl/movie/now_playing?api_key=$apiKey";
  static const popularMoviesPath = "$basUrl/movie/popular?api_key=$apiKey";
  static const topRatedMoviesPath = "$basUrl/movie/top_rated?api_key=$apiKey";
  static String searchResultsPath(int page, String query) =>
      "$basUrl/search/movie?api_key=$apiKey&query=$query&page=$page";
  static String movieDetailsPath(int movieId) =>
      "$basUrl/movie/$movieId?api_key=$apiKey";
  static String recommendationPath(int movieId) =>
      "$basUrl/movie/$movieId/recommendations?api_key=$apiKey";
  static const String baseImageUrl = "https://image.tmdb.org/t/p/w500";
  static String imageUrl(String path) => "$baseImageUrl$path";
}
