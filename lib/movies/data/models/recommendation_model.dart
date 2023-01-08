import 'package:movies_app/movies/domain/entities/recommendation.dart';

class RecommendationModel extends Recommendation {
  const RecommendationModel(
      {super.backdropPath, super.title, required super.id, super.posterPath});
  factory RecommendationModel.fromJson(Map<String, dynamic> json) =>
      RecommendationModel(
          backdropPath: json["backdrop_path"] ??
              json["poster_path"] ??
              "/kGzFbGhp99zva6oZODW5atUtnqi.jpg",
          posterPath: json["poster_path"] ??
              json["backdrop_path"] ??
              "/kGzFbGhp99zva6oZODW5atUtnqi.jpg",
          id: json["id"],
          title: json["original_title"] ?? '');
}
