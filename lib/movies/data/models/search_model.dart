import 'package:movies_app/movies/data/models/results_model.dart';
import 'package:movies_app/movies/domain/entities/search.dart';

class SearchModel extends Search {
  const SearchModel(
      {required super.page,
      required super.totalPages,
      required super.totalResults,
      required super.results});
  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        page: json["page"],
        totalPages: json["total_pages"],
        totalResults: json['total_results'],
        results: List<ResultsModel>.from(
            json["results"].map((e) => ResultsModel.fromJson(e))),
      );
}
