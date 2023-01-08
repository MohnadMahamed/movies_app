import 'package:movies_app/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.title,
    super.backdropPath,
    super.posterPath,
    required super.genreIds,
    required super.overview,
    required super.voteAverage,
    required super.releaseDate,
  });
  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        id: json["id"],
        title: json["original_title"],
        backdropPath: json["backdrop_path"] ??
            json["poster_path"] ??
            "/kGzFbGhp99zva6oZODW5atUtnqi.jpg",
        posterPath: json["poster_path"] ??
            json["backdrop_path"] ??
            "//kGzFbGhp99zva6oZODW5atUtnqi.jpg",
        genreIds: List<int>.from(json["genre_ids"].map((e) => e)),
        overview: json["overview"],
        voteAverage: json["vote_average"].toDouble(),
        releaseDate: json["release_date"],
      );
}
