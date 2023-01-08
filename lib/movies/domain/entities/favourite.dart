import 'package:equatable/equatable.dart';

class Favourite extends Equatable {
  final int id;
  final String title;
  final String? backdropPath;
  final String? posterPath;

  const Favourite(
      {required this.id,
      required this.title,
      this.backdropPath,
      this.posterPath});

  @override
  List<Object?> get props =>
      [id, title, backdropPath, posterPath, backdropPath];
}
