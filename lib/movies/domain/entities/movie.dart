import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String? backdropPath;
  final String? posterPath;
  final List<int> genreIds;
  final String overview;
  final String releaseDate;
  final double voteAverage;

  const Movie(
      {required this.id,
      required this.releaseDate,
      required this.title,
      this.backdropPath,
      this.posterPath,
      required this.genreIds,
      required this.overview,
      required this.voteAverage});

  @override
  List<Object?> get props => [
        id,
        title,
        backdropPath,
        genreIds,
        releaseDate,
        overview,
        voteAverage,
        posterPath
      ];
}
