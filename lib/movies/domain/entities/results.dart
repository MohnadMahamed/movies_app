import 'package:equatable/equatable.dart';

class Results extends Equatable {
  final int id;
  final String? backdropPath;
  final String? posterPath;
  final String? title;

  const Results(
      {required this.id, this.backdropPath, this.posterPath, this.title});
  @override
  List<Object?> get props => [id, backdropPath, title, posterPath];
}
