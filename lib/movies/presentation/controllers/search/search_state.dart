part of 'search_cubit.dart';

// abstract class SearchState extends Equatable {
//   const SearchState();

//   @override
//   List<Object> get props => [];
// }

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchToggleState extends SearchState {}

class SearchTtoggleState extends SearchState {}

class SearchMoviesLoadingState extends SearchState {}

class SearchMoviesErrorState extends SearchState {}

class SearchMoviesSuccessState extends SearchState {}

class IncreaseActivePageState extends SearchState {}

class DecreaseActivePageState extends SearchState {}

class PutActivePageOneState extends SearchState {}
