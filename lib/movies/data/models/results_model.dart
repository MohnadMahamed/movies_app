import 'package:movies_app/movies/domain/entities/results.dart';

class ResultsModel extends Results {
  const ResultsModel(
      {required super.id, super.backdropPath, super.title, super.posterPath});
  factory ResultsModel.fromJson(Map<String, dynamic> json) => ResultsModel(
        id: json["id"],
        posterPath: json["poster_path"] ??
            json["backdrop_path"] ??
            "/kGzFbGhp99zva6oZODW5atUtnqi.jpg",
        backdropPath: json["backdrop_path"] ??
            json["poster_path"] ??
            "/kGzFbGhp99zva6oZODW5atUtnqi.jpg",
        title: json['original_title'],
      );
}
