import 'package:equatable/equatable.dart';
import 'package:movies_app/movies/domain/entities/results.dart';

class Search extends Equatable {
  final int page;
  final int totalPages;
  final int totalResults;
  final List<Results> results;

  const Search(
      {required this.page,
      required this.totalPages,
      required this.totalResults,
      required this.results});

  @override
  List<Object?> get props => [page, totalPages, totalResults, results];
}
