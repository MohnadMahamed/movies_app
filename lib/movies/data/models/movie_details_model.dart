import 'package:movies_app/movies/data/models/genres_model.dart';
import 'package:movies_app/movies/domain/entities/movie_details.dart';

class MovieDetailsModel extends MovieDetails {
  const MovieDetailsModel(
      {super.backdropPath,
      super.posterPath,
      required super.id,
      required super.genres,
      required super.overview,
      required super.releaseDate,
      required super.runtime,
      required super.title,
      required super.voteAverage});
  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) =>
      MovieDetailsModel(
        backdropPath: json["backdrop_path"] ??
            json["poster_path"] ??
            "/kGzFbGhp99zva6oZODW5atUtnqi.jpg",
        posterPath: json["poster_path"] ??
            json["backdrop_path"] ??
            "/kGzFbGhp99zva6oZODW5atUtnqi.jpg",
        id: json["id"],
        genres: List<GenresModel>.from(
            json["genres"].map((e) => GenresModel.fromJson(e))),
        overview: json["overview"],
        releaseDate: json["release_date"],
        runtime: json["runtime"],
        title: json["original_title"],
        voteAverage: json["vote_average"].toDouble(),
      );
}
