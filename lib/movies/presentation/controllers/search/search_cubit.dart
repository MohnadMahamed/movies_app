import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/error/failure.dart';
import 'package:movies_app/movies/data/models/search_model.dart';
import 'package:movies_app/movies/domain/usecases/get_search_results_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.getSearchResultUseCase) : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

  final GetSearchResultUseCase getSearchResultUseCase;
  SearchModel searchMoviesList =
      const SearchModel(page: 0, totalPages: 0, totalResults: 0, results: []);
  TextEditingController searchController = TextEditingController();
  int activePage = 1;
  bool isSearch = false;
  final searchFocusNode = FocusNode();

  void checkForFocusNode() {
    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        isSearch = true;
        emit(SearchToggleState());
      } else if (!searchFocusNode.hasFocus) {
        isSearch = false;
        emit(SearchTtoggleState());
      }
    });
  }

  Future<Either<Failure, SearchModel>> searchMovies(
      SearchParameters searchParameters) async {
    emit(SearchMoviesLoadingState());
    final result = await getSearchResultUseCase.call(searchParameters);
    result.fold((l) {
      ServerFailure(l.message);
      emit(SearchMoviesErrorState());
    }, (r) {
      searchMoviesList = r;
      emit(SearchMoviesSuccessState());
    });
    return result;
  }

  void increaseActivePage() {
    if (activePage < searchMoviesList.totalPages) {
      activePage++;
      searchMovies(SearchParameters(activePage, searchController.text));
      emit(IncreaseActivePageState());
    }
  }

  void putActivePageOne() {
    activePage = 1;
    emit(PutActivePageOneState());
  }

  void decreaseActivePage() {
    if (activePage > 1) {
      activePage--;
      searchMovies(SearchParameters(activePage, searchController.text));
      emit(DecreaseActivePageState());
    }
  }
}
