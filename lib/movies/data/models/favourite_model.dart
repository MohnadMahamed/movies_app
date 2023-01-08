import 'package:movies_app/movies/domain/entities/favourite.dart';

class FavouriteModel extends Favourite {
  const FavouriteModel(
      {required super.id,
      required super.title,
      super.backdropPath,
      super.posterPath});
  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
      id: json['id'],
      title: json['original_title'],
      posterPath: json['poster_path'] ??
          json['backdrop_path'] ??
          "/kGzFbGhp99zva6oZODW5atUtnqi.jpg",
      backdropPath: json['backdrop_path'] ??
          json['poster_path'] ??
          "/kGzFbGhp99zva6oZODW5atUtnqi.jpg");

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'backdrop_path': backdropPath
    };
  }
}
