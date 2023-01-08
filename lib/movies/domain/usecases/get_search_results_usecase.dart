import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/core/usecase/base_usecase.dart';
import 'package:movies_app/movies/data/models/search_model.dart';
import 'package:movies_app/movies/domain/repository/base_movies_repository.dart';

class GetSearchResultUseCase
    extends BaseUseCase<SearchModel, SearchParameters> {
  final BaseMoviesRepository baseMoviesRepository;
  GetSearchResultUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, SearchModel>> call(SearchParameters parameters) async {
    return await baseMoviesRepository.getSearchResults(parameters);
  }
}

class SearchParameters extends Equatable {
  final int page;
  final String query;

  const SearchParameters(this.page, this.query);

  @override
  List<Object?> get props => [page, query];
}
